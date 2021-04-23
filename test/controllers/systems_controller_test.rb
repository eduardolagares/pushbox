require 'test_helper'

class SystemsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    create(:system)
    get systems_url, as: :json, headers: admin_headers
    assert_response :success
  end

  test 'should create system' do
    new_system = build(:system)
    assert_difference('System.count') do
      post systems_url, params: new_system.as_json, as: :json, headers: admin_headers
    end

    assert_response 201
  end

  test 'should show system' do
    @system = create(:system)
    get system_url(@system), as: :json, headers: admin_headers
    assert_response :success
  end

  test 'should update system' do
    @system = create(:system)
    new_system = build(:system)
    patch system_url(@system), params: new_system.as_json, as: :json, headers: admin_headers
    assert_response 200
    assert_equal json['label'], new_system.label
    assert_equal json['name'], new_system.name
  end

  test 'should destroy system' do
    @system = create(:system)
    assert_difference('System.count', -1) do
      delete system_url(@system), as: :json, headers: admin_headers
    end

    assert_response 204
  end
end
