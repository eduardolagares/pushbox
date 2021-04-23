require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  subject { build(:device) }

  context 'associations' do
    should belong_to(:provider)
    should belong_to(:system)
  end

  context 'validations' do
    should validate_presence_of(:provider_identifier)
    should validate_uniqueness_of(:provider_identifier).scoped_to(:provider_id, :system_id)
  end
end
