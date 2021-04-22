require "test_helper"

class DeviceTest < ActiveSupport::TestCase
  test "should has a unique condition for provider_identifier provider_id and system_id" do
    provider = providers(:one)
    system = systems(:one)
    
    device = Device.new({provider_identifier: '123', provider_id: provider.id, system_id: system.id})

    assert device.valid?
    assert device.save

    copy_device = Device.new({provider_identifier: '123', provider_id: provider.id, system_id: system.id})

    assert_not copy_device.valid?
    assert_not copy_device.save
  end
end
