require 'test_helper'

class RoutesControllerTest < ActionController::TestCase
  def setup
    @route = create(:route)
    @wellington = create(:city)
    @auckland = create(:city)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:routes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get index json" do
    res = get :index, format: :json
    JSON.parse res.body
    assert_response :success
  end

  test "should create route" do
    #needs cities to be populated before running
    #
    assert_difference('Route.count') do
      post :create, to_name: @auckland.name, from_name: @wellington.name, route: attributes_for(:route)
    end

    assert_redirected_to route_path(assigns(:route))
  end

  test "request invalid, should not create route" do
    assert_no_difference('Route.count') do
      post :create, to_name: '', from_name: '', route: attributes_for(:route)
    end
  end

  test "request invalid with no params, should not create route" do
    assert_no_difference('Route.count') do
      post :create
    end
  end

  test "should show route" do
    get :show, id: @route
    assert_response :success
  end

  test "should show route json" do
    res = get :show, id: @route, format: :json
    JSON.parse res.body
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @route
    assert_response :success
  end

  test "should not update route, no params" do
    patch :update, id: @route
    assert_redirected_to route_path(assigns(:route))
  end

  test "should update route" do
    patch :update, id: @route, route: { day: 'test' }
    assert_redirected_to route_path(assigns(:route))
  end

  test "should destroy route" do
    assert_difference('Route.count', -1) do
      delete :destroy, id: @route
    end

    assert_redirected_to routes_path
  end

  test "should get find" do
    get :find
    assert_response :success
  end

  test "should get results without parameters" do
    get :results
    assert_response :success
  end

  test "should get results with paramters" do
    get :results, city_to: @auckland.name, city_from: @wellington.name
    assert_response :success
  end

end
