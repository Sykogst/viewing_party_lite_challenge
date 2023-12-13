class WelcomeController < ApplicationController
  # before_action :require_user, only: :index

  def index
    @users = User.all
  end

  private

  # def require_user
  #   # render file: "public/404.html" unless current_user?
  #   redirect_to "/" unless current_user?
  # end
end
