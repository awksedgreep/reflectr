require 'test_helper'

class CurrentStatsControllerTest < ActionController::TestCase
  setup do
    @current_stat = current_stats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:current_stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create current_stat" do
    assert_difference('CurrentStat.count') do
      post :create, :current_stat => @current_stat.attributes
    end

    assert_redirected_to current_stat_path(assigns(:current_stat))
  end

  test "should show current_stat" do
    get :show, :id => @current_stat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @current_stat.to_param
    assert_response :success
  end

  test "should update current_stat" do
    put :update, :id => @current_stat.to_param, :current_stat => @current_stat.attributes
    assert_redirected_to current_stat_path(assigns(:current_stat))
  end

  test "should destroy current_stat" do
    assert_difference('CurrentStat.count', -1) do
      delete :destroy, :id => @current_stat.to_param
    end

    assert_redirected_to current_stats_path
  end
end
