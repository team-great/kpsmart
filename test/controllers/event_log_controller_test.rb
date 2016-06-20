require 'test_helper'

class EventLogControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get index with mail delivery" do
    create(:mail, :with_route)
    get :index
    assert_response :success
    assert_template :partial => '_mail_event'
  end

  test "should get index with route creation" do
    with_versioning do
      create(:route)
      get :index
      assert_response :success
      assert_template :partial => '_create_event'
    end
  end

  test "should get index with route edit" do
    with_versioning do
      route = create(:route)
      route.max_weight = 101
      route.save

      get :index
      assert_response :success
      assert_template :partial => '_update_event'
    end
  end

end
