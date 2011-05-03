require 'test_helper'

class StatsControllerTest < ActionController::TestCase
  setup do
    @stat = stats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stat" do
    assert_difference('Stat.count') do
      post :create, :stat => @stat.attributes
    end

    assert_redirected_to stat_path(assigns(:stat))
  end

  test "should show stat" do
    get :show, :id => @stat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @stat.to_param
    assert_response :success
  end

  test "should update stat" do
    put :update, :id => @stat.to_param, :stat => @stat.attributes
    assert_redirected_to stat_path(assigns(:stat))
  end

  test "should destroy stat" do
    assert_difference('Stat.count', -1) do
      delete :destroy, :id => @stat.to_param
    end

    assert_redirected_to stats_path
  end
end
