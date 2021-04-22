require "test_helper"

class TopicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @topic = topics(:one)
    @json_schema = {
      type: "object",
      required: [:id, :title, :description, :external_identifier]
    }
  end

  test "should get index" do
    get topics_url, as: :json
    assert_response :success
    assert JSON::Validator.validate(@json_schema, json_response.first)
  end

  test "should create topic" do
    assert_difference('Topic.count') do
      post topics_url, params: { title: @topic.title, description: @topic.description, external_identifier: @topic.external_identifier }, as: :json
    end

    assert_response 201
    assert JSON::Validator.validate(@json_schema, json_response)
  end

  test "should show topic" do
    get topic_url(@topic), as: :json
    assert_response :success
    assert JSON::Validator.validate(@json_schema, json_response)
  end

  test "should update topic" do
    new_title = 'new_title'
    new_description = 'new_description'
    new_external_identifier = 'new_external_identifier'
    
    put topic_url(@topic), params: { title: new_title, description: new_description, external_identifier: new_external_identifier }, as: :json
    
    assert_response 200

    assert JSON::Validator.validate(@json_schema, json_response)

    assert_equal json_response["title"], new_title
    assert_equal json_response["description"], new_description
    assert_equal json_response["external_identifier"], new_external_identifier
  end

end
