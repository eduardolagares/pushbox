# require "test_helper"

# class Devices::SubscriptionsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @device = devices(:one)
#     @subscription = subscriptions(:one)
#     @topic = topics(:one)
#   end

#   test "should get index" do
#     get device_subscriptions_url(@device), as: :json
#     assert_response :success
#   end

#   test "should create subscription" do
#     assert_difference('Subscription.count') do
#       post device_subscriptions_url(@device, nil), params: {
#         topic_id: @topic.id
#       }, as: :json
#     end

#     assert_response 201
#   end

#   test "should show subscription" do
#     get device_subscription_url(@device, @subscription), as: :json

#     assert_response :success
#   end

#   test "should destroy subscription" do
#     delete device_subscription_url(@device, @subscription), as: :json
#     assert_response 204

#     @subscription.reload
#     assert @subscription.canceled
#   end
# end
