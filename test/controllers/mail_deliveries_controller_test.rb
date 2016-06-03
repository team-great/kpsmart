require 'test_helper'

class MailDeliveriesControllerTest < ActionController::TestCase
  setup do
    @mail_delivery = mail_deliveries(:one)

    @to_city = cities(:one)
    @from_city = cities(:two)
  end

  def teardown
    @mail_delivery = nil

    @to_city = nil
    @from_city = nil
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
      post :create, {:to_name => @to_city.name, :from_name => @from_city.name, mail_delivery: { day: @mail_delivery.day, weight: @mail_delivery.weight, volume: @mail_delivery.volume, priority_name: @mail_delivery.priority }}
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
    patch :update, id: @mail_delivery, mail_delivery: {size: 2.16 }
    assert_redirected_to mail_delivery_path(assigns(:mail_delivery))
  end

  test "should destroy mail_delivery" do
    assert_difference('MailDelivery.count', -1) do
      delete :destroy, id: @mail_delivery
    end

    assert_redirected_to mail_deliveries_path
  end
end
