class HomeController < ApplicationController
  def index
  end

  def history
  end

  def log
  	@game = Game.new
  end
end
