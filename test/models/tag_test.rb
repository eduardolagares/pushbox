require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "alias has to be unique" do
    duplicated_alias = 'duplicated_alias'
    tag1 = Tag.new({
      name: 'Tag1',
      alias: duplicated_alias,
    })

    assert tag1.valid?
    assert tag1.save

    tag2 = Tag.new({
      name: 'Tag2',
      alias: duplicated_alias,
    })

    assert_not tag2.valid?
    assert_not tag2.save
  end
end
