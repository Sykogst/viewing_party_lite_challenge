class UsersController < ApplicationController
  before_action :require_user, only: :show

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      flash[:notice] = 'Successfully Added New User'
      redirect_to user_path(new_user)
    else
      flash[:alert] = "Error: #{error_message(new_user.errors)}"
      redirect_to register_user_path
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    user[:email] = user[:email].downcase if user

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_discover_index_path(user)
    else
      flash[:error] = user ? "Sorry, your password is incorrect." : "Sorry, your email was not found."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully"
    redirect_to landing_path
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def require_user
    unless current_user?
      flash[:alert] = "Must be logged in or registered to access this page."
      redirect_to landing_path
    end
  end
end