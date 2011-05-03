require 'test_helper'

class PollgroupsControllerTest < ActionController::TestCase
  setup do
    @pollgroup = pollgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pollgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pollgroup" do
    assert_difference('Pollgroup.count') do
      post :create, :pollgroup => @pollgroup.attributes
    end

    assert_redirected_to pollgroup_path(assigns(:pollgroup))
  end

  test "should show pollgroup" do
    get :show, :id => @pollgroup.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pollgroup.to_param
    assert_response :success
  end

  test "should update pollgroup" do
    put :update, :id => @pollgroup.to_param, :pollgroup => @pollgroup.attributes
    assert_redirected_to pollgroup_path(assigns(:pollgroup))
  end

  test "should destroy pollgroup" do
    assert_difference('Pollgroup.count', -1) do
      delete :destroy, :id => @pollgroup.to_param
    end

    assert_redirected_to pollgroups_path
  end
end
