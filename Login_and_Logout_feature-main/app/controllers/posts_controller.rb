class PostsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index, :feed]

  def index
    @posts = Post.all
    render json: @posts
  end

  def show 
    @post = Post.find(params[:id])
    render json: @post
  end

  def feed
  begin
    user = JUser.find(params[:user_id])
    @posts = user.posts.order(created_at: :desc)
    render json: @posts
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }
  rescue => e
    render json: { error: "Check everything and debug again"}
  end
end

  def create
    unless current_user
      return render json: { error: "Authentication required" }, status: 401
    end

    ActiveRecord::Base.transaction do
      begin
        Rails.logger.info "Received params: #{params.inspect}"
        Rails.logger.info "Current user: #{current_user.inspect}"
        
        post = current_user.posts.build(
          title: params[:post][:title],
          content: params[:post][:content],
          posted_by: current_user.profile.name
        )
        
        if post.save
          render json: post
        else
          render json: { error: "Post validation failed" }
          raise ActiveRecord::Rollback
        end
        
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Profile not found" }
      rescue NoMethodError
        render json: { 
          error: "Invalid request format",
          details: "Expected format: { post: { title: '...', content: '...' } }"
        }
      rescue => e
        render json: { 
          error: "Post creation failed",
          details: e.message 
        }
      end
    end
  end

  def update
    begin
      unless current_user
        return render json: { error: "Authentication required" }, status: 401
      end
      
      @post = current_user.posts.find(params[:id])

      if @post.update(
        title: params[:post][:title],
        content: params[:post][:content]
      )
        render json: @post
      else
        render json: { 
          error: "Post update failed",
        }
      end
    rescue ActiveRecord::RecordNotFound
      render json: { 
        error: "Post not found" 
      }
    end
  end

  def destroy
    begin
      unless current_user
        return render json: { error: "Authentication required" }, status: 401
      end
      
      @post = current_user.posts.find(params[:id])

      @post.destroy!
      render json: { message: "Post deleted successfully" }
    rescue ActiveRecord::RecordNotFound
      render json: { 
        error: "Post not found" 
      }
    end
  end
end