require "test_helper"

class SystemTest < ActiveSupport::TestCase
  test "alias has to be unique truth" do
    duplicated_alias = 'duplicated_alias'
    system1 = System.new({
      name: 'System1',
      alias: duplicated_alias
    })

    assert system1.valid?
    assert system1.save

    system2 = System.new({
      name: 'System2',
      alias: duplicated_alias
    })

    assert_not system2.valid?
    assert_not system2.save
  end
end
