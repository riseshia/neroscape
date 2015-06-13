class HomeController < ApplicationController
  before_action :locked?, except: :locked

  def index
  end

  def locked
  end
end
