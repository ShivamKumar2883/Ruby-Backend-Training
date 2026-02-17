class PostsController < ActionController::API
    before_action :authenticate_user, except: [:create, :feed, :index, :update, :destroy, :show, :index]

    def index
        @posts = Post.all
        respond_to :json
    end

    def show 
      @post = Post.find(params[:id])
      respond_to :json
    end

    def feed
        begin
          @user = JUser.find(params[:user_id])
          @posts = @user.posts.order(created_at: :desc)
          respond_to :json
        rescue ActiveRecord::RecordNotFound
          render json: { error: "User not found" }
        rescue => e
          render json: { error: "Check eveything and debug agin"}
        end
      end


#     def create
#         ActiveRecord::Base.transaction do
#             begin
#               Rails.logger.info "Received params: #{params.inspect}"
#       Rails.logger.info "Params[:post] class: #{params[:post].class}"
#       Rails.logger.info "Current user: #{current_user.inspect}"

#         @post = current_user.posts.build(
#           title: params[:post][:title],
#           content: params[:post][:content],
#           posted_by: current_user.profile.name
#         )
#                 if @post.save
#                     render json: @post
#                     # respond_to :json
#                 else
#                     render json:{
#                         error: "Post validation failed",
#                         details: @post.errors.full_messages
#                     }                    
#                     raise ActiveRecord::Rollback
#                 end
#     rescue NoMethodError
#       render json: { 
#         error: "Invalid request format",
#         details: "Expected format: { post: { title: '...', content: '...' } }"
#       }
#     rescue => e
#       render json: { 
#         error: "Post creation failed",
#         details: e.message 
#       }
#     end
#   end
# end

    def create
  ActiveRecord::Base.transaction do
    begin
      Rails.logger.info "Received params: #{params.inspect}"

      user = JUser.find(params[:j_user_id])

      @post = user.posts.build(
        title: params[:post][:title],
        content: params[:post][:content],
        posted_by: user.profile.name,
        j_user_id: user.id
      )

      if @post.save
        render json: @post, status: :created
      else
        render json: {
          error: "Post validation failed",
          details: @post.errors.full_messages
        }, status: :unprocessable_entity
        return
      end

    rescue ActiveRecord::RecordNotFound
      render json: { 
        error: "User not found",
        details: "User with ID #{params[:j_user_id]} does not exist"
      }, status: :not_found

    rescue NoMethodError
      render json: { 
        error: "Invalid request format",
        details: "Expected format: { post: { title: '...', content: '...' } }"
      }, status: :bad_request

    rescue => e
      render json: { 
        error: "Post creation failed",
        details: e.message 
      }, status: :internal_server_error
    end
  end
end

  

    def update
    begin
      @post = current_user.posts.find(params[:id])
      
      if post.update(
        title: params[:post][:title],
        content: params[:post][:content]
      )
        render json: post
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
      @post = current_user.posts.find(params[:id])
      post.destroy!
      render json: { message: "Post deleted successfully" }
    rescue ActiveRecord::RecordNotFound
      render json: { 
        error: "Post not found" 
      }
    end
  end

  def current_user
    @current_user
  end
end
