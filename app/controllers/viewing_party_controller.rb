class ViewingPartyController < ApplicationController
  before_action :require_user, only: :new

  def new
    @user = User.find(params[:user_id])
    @movie_facade = MoviesFacade.new.find_movie(params[:movie_id])
  end

  def create
    if params[:duration].to_i >= params[:movie_duration].to_i
      create_user_parties
      redirect_to user_path(params[:user_id])
    else
      flash[:alert] = "Not enough time"
      redirect_to "/users/#{params[:user_id]}/movies/#{params[:movie_id]}/viewing_party/new"
    end
  end

  private

  def create_user_parties
    party = Party.create(movie_id: params[:movie_id], movie_title: params[:title], start_time: params[:start_time], date: params[:date], image_path: params[:image], duration: params[:duration])
    UserParty.create!(user_id: params[:user_id], party_id: party.id, host: true)

    params[:invitees].each do |user_id, checkbox_value|
      if checkbox_value == "1"
        UserParty.create!(user_id: user_id.to_i, party_id: party.id, host: false)
      end
    end
  end

  def require_user
    unless current_user?
      flash[:alert] = "Must be logged in or registered to access this page."
      render file: "public/404.html"
      # redirect_to "/users/#{params[:user_id]}/movies/#{params[:movie_id]}"
    end
  end
end

