# HomeController
class HomeController < ApplicationController
  skip_before_action :locked?, only: :locked

  def index
    @recent_reviews = Review.includes(:game, :user).order('created_at DESC').limit(10)
    @next_games = Game.next_releases.limit(10)
    @reled_games = Game.released.limit(10)
  end

  def locked
    redirect_to root_path if current_user.try(:unlocked?)
  end

  def search
    return unless params[:query]
    @games = Game.where('title like ?', "%#{params[:query]}%")
    @brands = Brand.where('name like ?', "%#{params[:query]}%")
    @creators = Creator.where('name like ?', "%#{params[:query]}%")
  end
end
