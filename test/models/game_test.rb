require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "Game should have the necessary required validators" do
    game = Game.new
    assert_not game.valid?
    assert_equal [:player, :opponent, :played_at, :player_score, :opponent_score], game.errors.keys
  end

  test "Game should have numeric scores" do
    game = games(:game_1)
    game[:player_score] = 'x'
    game[:opponent_score] = 'x'

    assert_not game.valid?
    assert game.errors.messages[:player_score].include?("is not a number")
    assert game.errors.messages[:opponent_score].include?("is not a number")
  end

  test "Game should have integer scores" do
    game = games(:game_1)
    game[:player_score] = 1.1
    game[:opponent_score] = 5.2

    assert_not game.valid?
    assert_equal ["must be an integer"], game.errors.messages[:player_score]
    assert_equal ["must be an integer"], game.errors.messages[:opponent_score]
  end

  test "Game should be won by a two point margin" do
    game = games(:game_1)
    game[:player_score] = 21
    game[:opponent_score] = 20

    assert_not game.valid?
    assert_equal ["game needs to be won by a two point margin"], game.errors.messages[:player_score]
  end

  test "Game should have a top score of 21" do
    game = games(:game_1)
    game[:player_score] = 22
    game[:opponent_score] = 19

    assert_not game.valid?
    assert_equal ["must be less than 22"], game.errors.messages[:player_score]
  end

  test "Game should have a played_at date in the past" do
    game = games(:game_1)
    game[:played_at] = Time.zone.today + 1

    assert_not game.valid?
    assert_equal ["should be in the past"], game.errors.messages[:played_at]
  end

  test "score should return a predefined formated string with game scores" do
    game = games(:game_1)
    assert_equal "#{game.player_score} - #{game.opponent_score}", game.score
  end

  test "result should be computed as string W or L depending on the game score before saving the resrouce" do
    game = games(:game_1)

    game[:player_score] = 21
    game[:opponent_score] = 9
    game.save

    assert_equal 'W', game.result

    game[:player_score] = 9
    game[:opponent_score] = 21
    game.save

    assert_equal 'L', game.result
  end
end
