require "test_helper"
module Devices
  class NotificationsControllerTest < ActionDispatch::IntegrationTest

    test "should list all device notifications" do
      device = create(:device)
      create(:notification, destiny: device)
      create(:notification, destiny: device)
      create(:notification, destiny: device)
      get device_notifications_url(device, nil), headers: device_headers(device)

      assert_response 200
      assert_equal json.size, 3
    end

    test "should list all device notifications paginated" do
      device = create(:device)
      n1 = create(:notification, destiny: device)
      create(:notification, destiny: device)
      create(:notification, destiny: device)
      get device_notifications_url(device, nil), params: { page: 2, per_page: 2 }, headers: device_headers(device)

      assert_response 200
      assert_equal json.size, 1
      assert_equal json[0]["id"], n1.id # Default sort is created_at DESC
    end

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
end
