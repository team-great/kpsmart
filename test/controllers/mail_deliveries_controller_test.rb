require 'test_helper'

class MailDeliveriesControllerTest < ActionController::TestCase
  def setup
    @mail_delivery = create(:mail)

    @to_city = build(:city)
    @from_city = build(:city)
  end

  def teardown
    @mail_delivery.destroy

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
      post :create, {:to_name => @to_city.name, :from_name => @from_city.name, mail_delivery: attributes_for(:mail) }
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
    patch :update, id: @mail_delivery, mail_delivery: {:to_name => @to_city.name, :from_name => @from_city.name, weight: @mail_delivery.weight, volume: 2.16, priority_name: @mail_delivery.priority}
    assert_redirected_to mail_delivery_path(assigns(:mail_delivery))
  end

  test "should create json" do
    assert_difference('MailDelivery.count') do
      res = post :create, :to_name => @to_city.name, :from_name => @from_city.name, mail_delivery: attributes_for(:mail), format: :json
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
