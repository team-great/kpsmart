require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  def setup
    @city = create(:city)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cities)
  end

  test "should get index json" do
    res = get :index, format: :json
    JSON.parse res.body
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create city" do
    assert_difference('City.count') do
      post :create, city: attributes_for(:city)
    end

    assert_redirected_to city_path(assigns(:city))
  end

  test "should create city no params" do
    assert_no_difference('City.count') do
      post :create
    end
  end

  test "should create city duplicate params" do
    assert_no_difference('City.count') do
      post :create, city: attributes_for(:city, name: @city.name)
    end
  end

  test "should show city" do
    get :show, id: @city
    assert_response :success
  end

  test "should show city json" do
    res = get :show, id: @city, format: :json
    JSON.parse res.body
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @city
    assert_response :success
  end

  test "should update city" do
    patch :update, id: @city, city: {  }
    assert_redirected_to city_path(assigns(:city))
  end

  test "should destroy city" do
    assert_difference('City.count', -1) do
      delete :destroy, id: @city
    end

    assert_redirected_to cities_path
  end
end
