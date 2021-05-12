require 'test_helper'

class ProviderTest < ActiveSupport::TestCase
  subject { build(:provider) }

  context 'associations' do
    should have_many(:devices)
    should have_many(:notifications)
  end

  context 'validations' do
    should validate_presence_of(:label)
    should validate_presence_of(:name)
    # should validate_presence_of(:delivery_class_name)
    should validate_uniqueness_of(:label)
  end
end
