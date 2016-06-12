require 'test_helper'

class MailDeliveriesControllerTest < ActionController::TestCase
  def setup
    @mail_delivery = create(:mail, :with_route)

    @to_city = create(:city)
    @from_city = create(:city)
    create(:route, to: @to_city, from: @from_city)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_deliveries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_delivery" do
    assert_difference('MailDelivery.count') do
      post :create,  mail_delivery: attributes_for(:mail, :with_route, to_name: @to_city.name, from_name: @from_city.name)
    end
    assert_redirected_to mail_delivery_path(assigns(:mail_delivery))
  end

  test "should show mail_delivery" do
    get :show, id: @mail_delivery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mail_delivery
    assert_response :success
  end

  test "should update mail_delivery" do
    patch :update, id: @mail_delivery, mail_delivery: attributes_for(:mail, volume: 10)
    assert_redirected_to mail_delivery_path(assigns(:mail_delivery))
  end

  test "should create json" do
    assert_difference('MailDelivery.count') do
      res = post :create, mail_delivery: attributes_for(:mail, :with_route, to_name: @to_city.name, from_name: @from_city.name), format: :json
      JSON.parse res.body
    end

    assert_response :success
  end

  test "should show mail json" do
    res = get :show, id: @mail_delivery, format: :json
    JSON.parse res.body
    assert_response :success
  end

  test "should destroy mail_delivery" do
    assert_difference('MailDelivery.count', -1) do
      delete :destroy, id: @mail_delivery
    end

    assert_redirected_to mail_deliveries_path
  end
end
