require 'test_helper'

class WebParsersControllerTest < ActionController::TestCase
  setup do
    @web_parser = web_parsers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:web_parsers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create web_parser" do
    assert_difference('WebParser.count') do
      post :create, web_parser: {  }
    end

    assert_redirected_to web_parser_path(assigns(:web_parser))
  end

  test "should show web_parser" do
    get :show, id: @web_parser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @web_parser
    assert_response :success
  end

  test "should update web_parser" do
    patch :update, id: @web_parser, web_parser: {  }
    assert_redirected_to web_parser_path(assigns(:web_parser))
  end

  test "should destroy web_parser" do
    assert_difference('WebParser.count', -1) do
      delete :destroy, id: @web_parser
    end

    assert_redirected_to web_parsers_path
  end
end
