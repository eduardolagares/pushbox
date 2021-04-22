require "test_helper"

class DevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @provider = providers(:one)
    @system = systems(:one)
    @device = devices(:one)

    @json_schema = {
      type: "object",
      required: [:id, :provider_id, :system_id, :external_identifier, :provider_identifier, :extra_data, :tags]
    }

  end

  test "should get index" do
    get devices_url, as: :json
    assert JSON::Validator.validate(@json_schema, json_response.first)
    assert_response :success
  end

  test "should create device" do
    assert_difference('Device.count') do
      post devices_url, params: {  
          provider_alias: @provider.alias, 
          system_alias: @system.alias, 
          provider_identifier: '1029381203812093AJSD0192J309J',
          tags: @device.tags 
        }, as: :json
    end

    assert_response 201
    assert JSON::Validator.validate(@json_schema, json_response)
  end

  test "should update device on create method" do
    identifier = 'duplicated-identifier'

    @provider = providers(:one)
    @system = systems(:one)
    
    res = Device.create!({
      provider_identifier: identifier,
      provider_id: @provider.id, 
      system_id: @system.id
    })

    post devices_url, params: { 
        provider_alias: @provider.alias, 
        provider_identifier: identifier,
        system_alias: @system.alias
      }, as: :json

    assert_response 200
    assert JSON::Validator.validate(@json_schema, json_response)
  end

  test "should show device" do
    get device_url(@device), as: :json
    assert JSON::Validator.validate(@json_schema, json_response)
    assert_response :success
  end

  test "should update device" do
    new_external_identifier = 'new-external-identifier'
    new_tags = ['a', 'b']
    new_provider_identifier = 'ignored_new_provider_identificator'
    
    patch device_url(@device), params: { 
      external_identifier: new_external_identifier, 
      provider_identifier: new_provider_identifier,
      tags: new_tags 
    }, as: :json
    
    assert JSON::Validator.validate(@json_schema, json_response)

    assert_equal new_external_identifier, json_response["external_identifier"]
    assert_equal new_tags, json_response["tags"]

    # Provider identifier cant be changed
    assert_not_equal new_provider_identifier, json_response["provider_identifier"]
    
    assert_response 200
  end
end
