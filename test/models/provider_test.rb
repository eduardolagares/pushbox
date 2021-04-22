require "test_helper"

class ProviderTest < ActiveSupport::TestCase
  test "alias has to be unique" do
    duplicated_alias = 'duplicated_alias'
    provider1 = Provider.new({
      name: 'Provider1',
      alias: duplicated_alias,
      delivery_class_name: 'DeliveryProvider1'
    })

    assert provider1.valid?
    assert provider1.save

    provider2 = Provider.new({
      name: 'Provider2',
      alias: duplicated_alias,
      delivery_class_name: 'DeliveryProvider2'
    })

    assert_not provider2.valid?
    assert_not provider2.save
  end
end
