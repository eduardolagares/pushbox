require "test_helper"

class Devices::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should create a notification" do
    assert_difference('Notification.count') do
      device = create(:device)
      new_notification = build(:notification)
      post device_notifications_url(device, nil), params: {
        title: new_notification.title,
        subtitle: new_notification.subtitle,
        body: new_notification.body,
        body_type: new_notification.body_type,
        data: new_notification.data,
        tag: new_notification.tag
      }, as: :json, headers: admin_headers
    end

    assert_response 201
  end
end
