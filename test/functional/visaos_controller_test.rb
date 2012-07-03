require 'test_helper'

class VisaosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visao" do
    assert_difference('Visao.count') do
      post :create, :visao => { }
    end

    assert_redirected_to visao_path(assigns(:visao))
  end

  test "should show visao" do
    get :show, :id => visaos(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => visaos(:one).id
    assert_response :success
  end

  test "should update visao" do
    put :update, :id => visaos(:one).id, :visao => { }
    assert_redirected_to visao_path(assigns(:visao))
  end

  test "should destroy visao" do
    assert_difference('Visao.count', -1) do
      delete :destroy, :id => visaos(:one).id
    end

    assert_redirected_to visaos_path
  end
end
