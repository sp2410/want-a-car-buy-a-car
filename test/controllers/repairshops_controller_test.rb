require 'test_helper'

class RepairshopsControllerTest < ActionController::TestCase
  setup do
    @repairshop = repairshops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repairshops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repairshop" do
    assert_difference('Repairshop.count') do
      post :create, repairshop: { city: @repairshop.city, description: @repairshop.description, phone: @repairshop.phone, state: @repairshop.state, title: @repairshop.title, zipcode: @repairshop.zipcode }
    end

    assert_redirected_to repairshop_path(assigns(:repairshop))
  end

  test "should show repairshop" do
    get :show, id: @repairshop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repairshop
    assert_response :success
  end

  test "should update repairshop" do
    patch :update, id: @repairshop, repairshop: { city: @repairshop.city, description: @repairshop.description, phone: @repairshop.phone, state: @repairshop.state, title: @repairshop.title, zipcode: @repairshop.zipcode }
    assert_redirected_to repairshop_path(assigns(:repairshop))
  end

  test "should destroy repairshop" do
    assert_difference('Repairshop.count', -1) do
      delete :destroy, id: @repairshop
    end

    assert_redirected_to repairshops_path
  end
end
