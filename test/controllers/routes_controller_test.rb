require 'test_helper'

class RoutesControllerTest < ActionController::TestCase
  setup do
    @route = routes(:one)
    @wellington = cities(:Wellington)
    @auckland = cities(:Auckland)
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

  test "should create route" do
    #needs cities to be populated before running
    #
    assert_difference('Route.count') do
      post :create, to_name: 'Auckland', from_name: 'Wellington',  route: {priority: 'Air', provider: 'NZ POST', weight_cost: 5, weight_price: 5, volume_cost: 10, volume_price: 10, max_weight: 10, max_volume: 20, duration: 1, frequency: 1, day: 'Monday'}
    end

    assert_redirected_to route_path(assigns(:route))
  end

  test "should show route" do
    get :show, id: @route
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @route
    assert_response :success
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
end
