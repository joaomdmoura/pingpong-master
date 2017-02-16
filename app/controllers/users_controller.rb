class UsersController < ApplicationController
  def index
  	@users = User.all.order("rating DESC")
  end
end
