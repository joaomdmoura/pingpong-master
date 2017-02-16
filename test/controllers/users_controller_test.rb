require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should redirect if get index and logged out" do
    get :index
    assert_response :redirect
  end

  test "should get index if logged in" do
    user = users(:default)
    sign_in user

    get :index
    assert_response :success
  end

  test "index should order users by their ratings" do
    users = ['a', 'b', 'c', 'd'].map do |u|
      User.create!(
        email: "#{u}@regalii.com",
        password: 'secret123',
        rating: rand(1000...2000)
      )
    end

    sign_in users.first

    get :index
    assert_equal User.all.order("rating DESC"), assigns(:users)
  end
end
