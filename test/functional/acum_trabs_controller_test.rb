require 'test_helper'

class AcumTrabsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:acum_trabs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create acum_trab" do
    assert_difference('AcumTrab.count') do
      post :create, :acum_trab => { }
    end

    assert_redirected_to acum_trab_path(assigns(:acum_trab))
  end

  test "should show acum_trab" do
    get :show, :id => acum_trabs(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => acum_trabs(:one).id
    assert_response :success
  end

  test "should update acum_trab" do
    put :update, :id => acum_trabs(:one).id, :acum_trab => { }
    assert_redirected_to acum_trab_path(assigns(:acum_trab))
  end

  test "should destroy acum_trab" do
    assert_difference('AcumTrab.count', -1) do
      delete :destroy, :id => acum_trabs(:one).id
    end

    assert_redirected_to acum_trabs_path
  end
end
