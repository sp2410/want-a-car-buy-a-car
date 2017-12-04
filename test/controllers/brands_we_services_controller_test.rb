require 'test_helper'

class BrandsWeServicesControllerTest < ActionController::TestCase
  setup do
    @brands_we_service = brands_we_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brands_we_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brands_we_service" do
    assert_difference('BrandsWeService.count') do
      post :create, brands_we_service: { repairshop: @brands_we_service.repairshop, title: @brands_we_service.title }
    end

    assert_redirected_to brands_we_service_path(assigns(:brands_we_service))
  end

  test "should show brands_we_service" do
    get :show, id: @brands_we_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brands_we_service
    assert_response :success
  end

  test "should update brands_we_service" do
    patch :update, id: @brands_we_service, brands_we_service: { repairshop: @brands_we_service.repairshop, title: @brands_we_service.title }
    assert_redirected_to brands_we_service_path(assigns(:brands_we_service))
  end

  test "should destroy brands_we_service" do
    assert_difference('BrandsWeService.count', -1) do
      delete :destroy, id: @brands_we_service
    end

    assert_redirected_to brands_we_services_path
  end
end
