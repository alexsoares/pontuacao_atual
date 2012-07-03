require 'test_helper'

class RemocaosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:remocaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create remocao" do
    assert_difference('Remocao.count') do
      post :create, :remocao => { }
    end

    assert_redirected_to remocao_path(assigns(:remocao))
  end

  test "should show remocao" do
    get :show, :id => remocaos(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => remocaos(:one).id
    assert_response :success
  end

  test "should update remocao" do
    put :update, :id => remocaos(:one).id, :remocao => { }
    assert_redirected_to remocao_path(assigns(:remocao))
  end

  test "should destroy remocao" do
    assert_difference('Remocao.count', -1) do
      delete :destroy, :id => remocaos(:one).id
    end

    assert_redirected_to remocaos_path
  end
end
