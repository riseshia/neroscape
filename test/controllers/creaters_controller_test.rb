require 'test_helper'

class CreatersControllerTest < ActionController::TestCase
  setup do
    @creater = creaters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:creaters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create creater" do
    assert_difference('Creater.count') do
      post :create, creater: { furigana: @creater.furigana, name: @creater.name }
    end

    assert_redirected_to creater_path(assigns(:creater))
  end

  test "should show creater" do
    get :show, id: @creater
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @creater
    assert_response :success
  end

  test "should update creater" do
    patch :update, id: @creater, creater: { furigana: @creater.furigana, name: @creater.name }
    assert_redirected_to creater_path(assigns(:creater))
  end

  test "should destroy creater" do
    assert_difference('Creater.count', -1) do
      delete :destroy, id: @creater
    end

    assert_redirected_to creaters_path
  end
end
