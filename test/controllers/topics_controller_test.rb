require 'test_helper'

class TopicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @topic = create(:topic)
    @json_schema = {
      type: 'object',
      required: %i[id title description external_identifier]
    }
  end

  test 'should get index' do
    get topics_url, as: :json, headers: client_headers
    assert_response :success
    assert JSON::Validator.validate(@json_schema, json.first)
  end

  test 'should create topic' do
    assert_difference('Topic.count') do
      new_topic = build(:topic)
      post topics_url, params: new_topic.as_json, as: :json, headers: admin_headers
    end
    assert_response 201
    assert JSON::Validator.validate(@json_schema, json)
  end

  test 'should show topic' do
    get topic_url(@topic), as: :json, headers: client_headers
    assert_response :success
    assert JSON::Validator.validate(@json_schema, json)
  end

  test 'should update topic' do
    new_topic = build(:topic)
    put topic_url(@topic), params: new_topic.as_json, as: :json, headers: admin_headers

    assert_response 200

    assert JSON::Validator.validate(@json_schema, json)

    assert_equal json['title'], new_topic.title
    assert_equal json['description'], new_topic.description
    assert_equal json['external_identifier'], new_topic.external_identifier
  end
end
