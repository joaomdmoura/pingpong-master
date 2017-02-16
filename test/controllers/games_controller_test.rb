require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "should redirect if get index and logged out" do
    get :index
    assert_response :redirect
  end

  test "should redirect if get new and logged out" do
    get :new
    assert_response :redirect
  end


  test "should redirect if post create and logged out" do
    post :create
    assert_response :redirect
  end

  test "should filter games on index by the current_user" do
    user = users(:default)
    sign_in user

    game = games(:game_1)
    game.player = user
    game.save

    get :index

    assert_response :success
    assert_equal user.games, assigns(:games)
  end

  test "create should automatically assign player as the current_user" do
    user = users(:default)
    sign_in user

    params = { game:
      {
        opponent_id: users(:user_2).id,
        played_at: Time.zone.today,
        player_score: 1,
        opponent_score: 21
      }
    }

    post :create, params

    assert_response :redirect
    assert_equal user, assigns(:game).player
  end
end
