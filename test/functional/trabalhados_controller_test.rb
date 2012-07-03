require 'test_helper'

class TrabalhadosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trabalhados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trabalhado" do
    assert_difference('Trabalhado.count') do
      post :create, :trabalhado => { }
    end

    assert_redirected_to trabalhado_path(assigns(:trabalhado))
  end

  test "should show trabalhado" do
    get :show, :id => trabalhados(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => trabalhados(:one).id
    assert_response :success
  end

  test "should update trabalhado" do
    put :update, :id => trabalhados(:one).id, :trabalhado => { }
    assert_redirected_to trabalhado_path(assigns(:trabalhado))
  end

  test "should destroy trabalhado" do
    assert_difference('Trabalhado.count', -1) do
      delete :destroy, :id => trabalhados(:one).id
    end

    assert_redirected_to trabalhados_path
  end
end
