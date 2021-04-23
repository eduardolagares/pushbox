require "test_helper"

class Devices::SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @device = create(:device)
    @topic = create(:topic)
  end

  test "should get index by device" do
    create(:subscription, device: @device)
    create(:subscription, device: @device)
    get device_subscriptions_url(@device), as: :json, headers: device_headers(@device)
    assert_response :success
    assert json.size, 2
  end
  test "should not get index by device with wrong api key" do
    wrong_device = create(:device)
    create(:subscription, device: @device)
    create(:subscription, device: @device)
    get device_subscriptions_url(@device), as: :json, headers: device_headers(wrong_device)
    assert_response :unauthorized
  end

  test "should get index by admin" do
    create(:subscription, device: @device)
    create(:subscription, device: @device)
    create(:subscription, device: @device)
    get device_subscriptions_url(@device), as: :json, headers: admin_headers
    assert_response :success
    assert json.size, 3
  end

  test "should create subscription" do
    assert_difference('Subscription.count') do
      post device_subscriptions_url(@device, nil), params: {
        topic_id: @topic.id
      }, as: :json, headers: device_headers(@device)
    end

    assert_response 201
  end
  

  test "should show subscription" do
    subscription = create(:subscription)
    get device_subscription_url(@device, subscription), as: :json, headers: device_headers(subscription.device)

    assert_response :success
  end

  test "should destroy subscription" do
    subscription = create(:subscription)
    delete device_subscription_url(@device, subscription), as: :json, headers: device_headers(subscription.device)
    assert_response 204

    subscription.reload
    assert subscription.canceled
  end
end
