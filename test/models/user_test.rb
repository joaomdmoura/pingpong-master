require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "User's games method should return all mathces an user participated" do
    user = users(:user_1)
    games = games(:game_1, :game_2)

    assert_equal user.games, games
  end

  test "New user should have a dafult rating of 1000" do
    user = User.new

    assert_equal 1000, user.rating
  end

end
