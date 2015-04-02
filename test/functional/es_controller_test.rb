require 'test_helper'

class EsControllerTest < ActionController::TestCase
  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get result" do
    get :result
    assert_response :success
  end

  test "should get item" do
    get :item
    assert_response :success
  end

  test "should get user" do
    get :user
    assert_response :success
  end

end
