require 'test_helper'

class SpecializationsControllerTest < ActionController::TestCase
  setup do
    @specialization = specializations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:specializations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create specialization" do
    assert_difference('Specialization.count') do
      post :create, specialization: { title: @specialization.title }
    end

    assert_redirected_to specialization_path(assigns(:specialization))
  end

  test "should show specialization" do
    get :show, id: @specialization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @specialization
    assert_response :success
  end

  test "should update specialization" do
    patch :update, id: @specialization, specialization: { title: @specialization.title }
    assert_redirected_to specialization_path(assigns(:specialization))
  end

  test "should destroy specialization" do
    assert_difference('Specialization.count', -1) do
      delete :destroy, id: @specialization
    end

    assert_redirected_to specializations_path
  end
end
