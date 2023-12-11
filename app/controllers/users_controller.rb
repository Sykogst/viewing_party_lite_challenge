class UsersController < ApplicationController
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

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end