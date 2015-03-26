require 'test_helper'

class ClassicVotingsControllerTest < ActionController::TestCase
  setup do
    @classic_voting = classic_votings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classic_votings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create classic_voting" do
    assert_difference('ClassicVoting.count') do
      post :create, classic_voting: {  }
    end

    assert_redirected_to classic_voting_path(assigns(:classic_voting))
  end

  test "should show classic_voting" do
    get :show, id: @classic_voting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @classic_voting
    assert_response :success
  end

  test "should update classic_voting" do
    patch :update, id: @classic_voting, classic_voting: {  }
    assert_redirected_to classic_voting_path(assigns(:classic_voting))
  end

  test "should destroy classic_voting" do
    assert_difference('ClassicVoting.count', -1) do
      delete :destroy, id: @classic_voting
    end

    assert_redirected_to classic_votings_path
  end
end
