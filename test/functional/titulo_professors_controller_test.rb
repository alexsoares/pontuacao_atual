require 'test_helper'

class TituloProfessorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:titulo_professors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create titulo_professor" do
    assert_difference('TituloProfessor.count') do
      post :create, :titulo_professor => { }
    end

    assert_redirected_to titulo_professor_path(assigns(:titulo_professor))
  end

  test "should show titulo_professor" do
    get :show, :id => titulo_professors(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => titulo_professors(:one).id
    assert_response :success
  end

  test "should update titulo_professor" do
    put :update, :id => titulo_professors(:one).id, :titulo_professor => { }
    assert_redirected_to titulo_professor_path(assigns(:titulo_professor))
  end

  test "should destroy titulo_professor" do
    assert_difference('TituloProfessor.count', -1) do
      delete :destroy, :id => titulo_professors(:one).id
    end

    assert_redirected_to titulo_professors_path
  end
end
