require 'test_helper'

class ImageItemsControllerTest < ActionController::TestCase
  setup do
    @image_item = image_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:image_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create image_item" do
    assert_difference('ImageItem.count') do
      post :create, image_item: {  }
    end

    assert_redirected_to image_item_path(assigns(:image_item))
  end

  test "should show image_item" do
    get :show, id: @image_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @image_item
    assert_response :success
  end

  test "should update image_item" do
    patch :update, id: @image_item, image_item: {  }
    assert_redirected_to image_item_path(assigns(:image_item))
  end

  test "should destroy image_item" do
    assert_difference('ImageItem.count', -1) do
      delete :destroy, id: @image_item
    end

    assert_redirected_to image_items_path
  end
end
