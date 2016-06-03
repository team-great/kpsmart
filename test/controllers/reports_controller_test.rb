require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  #
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get revenue" do
    get :revenue
    assert_response :success
  end
end
