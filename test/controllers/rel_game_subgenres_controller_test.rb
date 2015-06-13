require 'test_helper'

class RelGameSubgenresControllerTest < ActionController::TestCase
  setup do
    @rel_game_subgenre = rel_game_subgenres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rel_game_subgenres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rel_game_subgenre" do
    assert_difference('RelGameSubgenre.count') do
      post :create, rel_game_subgenre: { game_id: @rel_game_subgenre.game_id, subgenre_id: @rel_game_subgenre.subgenre_id }
    end

    assert_redirected_to rel_game_subgenre_path(assigns(:rel_game_subgenre))
  end

  test "should show rel_game_subgenre" do
    get :show, id: @rel_game_subgenre
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rel_game_subgenre
    assert_response :success
  end

  test "should update rel_game_subgenre" do
    patch :update, id: @rel_game_subgenre, rel_game_subgenre: { game_id: @rel_game_subgenre.game_id, subgenre_id: @rel_game_subgenre.subgenre_id }
    assert_redirected_to rel_game_subgenre_path(assigns(:rel_game_subgenre))
  end

  test "should destroy rel_game_subgenre" do
    assert_difference('RelGameSubgenre.count', -1) do
      delete :destroy, id: @rel_game_subgenre
    end

    assert_redirected_to rel_game_subgenres_path
  end
end
