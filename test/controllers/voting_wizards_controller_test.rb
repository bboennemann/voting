require 'test_helper'

class VotingWizardsControllerTest < ActionController::TestCase
  setup do
    @voting_wizard = voting_wizards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:voting_wizards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create voting_wizard" do
    assert_difference('VotingWizard.count') do
      post :create, voting_wizard: {  }
    end

    assert_redirected_to voting_wizard_path(assigns(:voting_wizard))
  end

  test "should show voting_wizard" do
    get :show, id: @voting_wizard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @voting_wizard
    assert_response :success
  end

  test "should update voting_wizard" do
    patch :update, id: @voting_wizard, voting_wizard: {  }
    assert_redirected_to voting_wizard_path(assigns(:voting_wizard))
  end

  test "should destroy voting_wizard" do
    assert_difference('VotingWizard.count', -1) do
      delete :destroy, id: @voting_wizard
    end

    assert_redirected_to voting_wizards_path
  end
end
