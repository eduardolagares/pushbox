require "test_helper"

class Devices::SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @device = create(:device)
    @topic = create(:topic)
  end

  test "should get index" do
    create(:subscription)
    create(:subscription)
    get device_subscriptions_url(@device), as: :json, headers: client_headers
    assert_response :success
    assert json.size, 2
  end

  test "should create subscription" do
    assert_difference('Subscription.count') do
      post device_subscriptions_url(@device, nil), params: {
        topic_id: @topic.id
      }, as: :json, headers: client_headers
    end

    assert_response 201
  end

  test "should show subscription" do
    subscription = create(:subscription)
    get device_subscription_url(@device, subscription), as: :json, headers: client_headers

    assert_response :success
  end

  test "should destroy subscription" do
    subscription = create(:subscription)
    delete device_subscription_url(@device, subscription), as: :json, headers: client_headers
    assert_response 204

    subscription.reload
    assert subscription.canceled
  end
end
