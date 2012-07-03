require 'test_helper'

class MensagemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mensagems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mensagem" do
    assert_difference('Mensagem.count') do
      post :create, :mensagem => { }
    end

    assert_redirected_to mensagem_path(assigns(:mensagem))
  end

  test "should show mensagem" do
    get :show, :id => mensagems(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => mensagems(:one).id
    assert_response :success
  end

  test "should update mensagem" do
    put :update, :id => mensagems(:one).id, :mensagem => { }
    assert_redirected_to mensagem_path(assigns(:mensagem))
  end

  test "should destroy mensagem" do
    assert_difference('Mensagem.count', -1) do
      delete :destroy, :id => mensagems(:one).id
    end

    assert_redirected_to mensagems_path
  end
end
