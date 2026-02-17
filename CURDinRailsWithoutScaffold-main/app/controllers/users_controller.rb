class UsersController < ApplicationController
  
  #shows all users
  def index
    users = User.all
    render :index, locals: { users: users, notice: flash.delete(:notice) }
  end

  #shows one user for show
  def show
    user = User.find(params[:id])
    render :show, locals: { user: user }
  end

  # new user form
  def new
    user = User.new
    render :new, locals: { user: user, alert: flash.delete(:alert) }
  end

  #create user
  def create
    user = User.new(params.require(:user).permit(:name, :email, :password))
    if user.save
      flash[:notice] = 'User created successfully'
      users = User.all
      render :index, locals: { users: users, notice: flash.delete(:notice) }
    else
      render :new, locals: { user: user, alert: user.errors.full_messages.to_sentence }
    end
  end

  # edit user form
  def edit
    user = User.find(params[:id])
    render :edit, locals: { user: user, alert: flash.delete(:alert) }
  end

  #update user
  def update
    user = User.find(params[:id])
    if user.update(params.require(:user).permit(:name, :email, :password))
      flash[:notice] = 'Updated successfully'
      users = User.all
      render :index, locals: { users: users, notice: flash.delete(:notice) }
    else
      render :edit, locals: { user: user, alert: user.errors.full_messages.to_sentence }
    end
  end

  #delete user
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:notice] = 'User deleted successfully'
    users = User.all
    render :index, locals: { users: users, notice: flash.delete(:notice) }
  end
end
