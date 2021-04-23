require 'test_helper'

class ApiKeyGeneratorTest < ActiveSupport::TestCase
  test 'should generate a api_key on create' do
    device = create(:device)

    assert_not_empty device.api_key
  end
end
