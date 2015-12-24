# HomeController
class HomeController < ApplicationController
  skip_before_action :locked?, only: :locked

  def index
    @recent_reviews = Review.includes(:game, :user).order('created_at DESC').limit(10)
    @next_games = Game.where('release_date >= ?', Time.zone.today).order('release_date ASC').limit(10)
  end

  def locked
  end
end
