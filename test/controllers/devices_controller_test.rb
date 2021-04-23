require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @json_schema = {
      type: 'object',
      required: %i[id provider_id system_id external_identifier provider_identifier extra_data tags api_key]
    }
  end
  test 'should not get index' do
    create(:device)

    get devices_url, as: :json, headers: client_headers
    assert_response :unauthorized
  end

  test 'should get index and validate schema' do
    create(:device)
    get devices_url, as: :json, headers: admin_headers

    assert JSON::Validator.validate(@json_schema, json.first)
    assert_response :success
  end

  test 'should get index filtered by system_label' do
    system = create(:system)
    create(:device, system: system)
    create(:device)
    create(:device)
    get devices_url({ system_label: system.label }), as: :json, headers: admin_headers
    assert_response :success
    assert_equal json.size, 1
  end

  test 'should get index filtered by provider_label' do
    provider = create(:provider)
    create(:device, provider: provider)
    create(:device)
    create(:device)
    get devices_url({ provider_label: provider.label }), as: :json, headers: admin_headers
    assert_response :success
    assert_equal json.size, 1
  end

  test 'should get index filtered by external_identifier' do
    d1 = create(:device)
    create(:device)
    create(:device)
    get devices_url({ external_identifier: d1.external_identifier }), as: :json, headers: admin_headers
    assert_response :success
    assert_equal json.size, 1
  end

  test 'should get index paginated' do
    create(:device)
    create(:device)
    d3 = create(:device)
    d4 = create(:device)
    get devices_url({ page: 2, per_page: 2 }), as: :json, headers: admin_headers
    assert_response :success
    assert_equal 2, json.size
    assert json.map { |d| d['id'] }.include?(d3.id)
    assert json.map { |d| d['id'] }.include?(d4.id)
  end

  test 'should create device' do
    assert_difference('Device.count') do
      system = create(:system)
      provider = create(:provider)
      new_device = build(:device, system: system, provider: provider)
      post devices_url, params: {
        provider_label: new_device.provider.label,
        system_label: new_device.system.label,
        provider_identifier: new_device.provider_identifier,
        tags: new_device.tags
      }, as: :json, headers: client_headers
    end

    assert_response 201
    assert JSON::Validator.validate(@json_schema, json)
  end

  test 'should show device' do
    device = create(:device)
    get device_url(device), as: :json, headers: device_headers(device)
    assert JSON::Validator.validate(@json_schema, json)
    assert_response :success
  end

  test 'should update device' do
    device = create(:device)
    new_device = build(:device)
    patch device_url(device), params: new_device.as_json, as: :json, headers: device_headers(device)

    assert JSON::Validator.validate(@json_schema, json)

    assert_equal new_device.external_identifier, json['external_identifier']
    assert_equal new_device.tags, json['tags']
    assert_not_equal new_device.provider_identifier, json['provider_identifier']

    assert_response 200
  end

  test 'should not update device' do
    wronog_device = create(:device)
    device = create(:device)
    new_device = build(:device)
    patch device_url(device), params: new_device.as_json, as: :json, headers: device_headers(wronog_device)

    assert_response :unauthorized
  end
end
