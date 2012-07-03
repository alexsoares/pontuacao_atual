require 'test_helper'

class RolesUsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:role_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create role_user" do
    assert_difference('RoleUser.count') do
      post :create, :role_user => { }
    end

    assert_redirected_to role_user_path(assigns(:role_user))
  end

  test "should show role_user" do
    get :show, :id => role_users(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => role_users(:one).id
    assert_response :success
  end

  test "should update role_user" do
    put :update, :id => role_users(:one).id, :role_user => { }
    assert_redirected_to role_user_path(assigns(:role_user))
  end

  test "should destroy role_user" do
    assert_difference('RoleUser.count', -1) do
      delete :destroy, :id => role_users(:one).id
    end

    assert_redirected_to role_users_path
  end
end
