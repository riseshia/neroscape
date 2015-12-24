# HomeController
class HomeController < ApplicationController
  before_action :locked?, except: :locked

  def index
    @recent_reviews = Review.includes(:game, :user).order('created_at DESC').limit(10)
    @next_games = Game.where('release_date >= ?', Date.today).order('release_date ASC').limit(10)
  end

  def locked
  end
end
