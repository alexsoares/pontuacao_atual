require 'test_helper'

class CorrecaosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:correcaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create correcao" do
    assert_difference('Correcao.count') do
      post :create, :correcao => { }
    end

    assert_redirected_to correcao_path(assigns(:correcao))
  end

  test "should show correcao" do
    get :show, :id => correcaos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => correcaos(:one).to_param
    assert_response :success
  end

  test "should update correcao" do
    put :update, :id => correcaos(:one).to_param, :correcao => { }
    assert_redirected_to correcao_path(assigns(:correcao))
  end

  test "should destroy correcao" do
    assert_difference('Correcao.count', -1) do
      delete :destroy, :id => correcaos(:one).to_param
    end

    assert_redirected_to correcaos_path
  end
end
