require "test_helper"

module Topics
  class NotificationsControllerTest < ActionDispatch::IntegrationTest
    test "should create a notification" do
      provider = create(:provider)
      topic = create(:topic)
      new_notification = build(:notification)

      assert_difference('Notification.count') do
        post topic_notifications_url(topic, nil), params: {
          title: new_notification.title,
          subtitle: new_notification.subtitle,
          body: new_notification.body,
          body_type: new_notification.body_type,
          data: new_notification.data,
          tag: new_notification.tag,
          provider_label: provider.label
        }, as: :json, headers: admin_headers
      end

      assert_response 201

      assert json["destiny_type"], topic.class.name
      assert json["destiny_id"], topic.id
      assert json["provider_id"], provider.id
    end
  end
end
