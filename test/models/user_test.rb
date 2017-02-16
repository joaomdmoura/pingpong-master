require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "games should return all mathces an user participated" do
    user = users(:user_1)
    games = games(:game_1, :game_2)

    assert_equal user.games, games
  end

end
