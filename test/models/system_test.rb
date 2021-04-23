require 'test_helper'

class SystemTest < ActiveSupport::TestCase
  subject { build(:system) }

  context 'associations' do
    should have_many(:devices)
  end

  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:label)
    should validate_uniqueness_of(:label)
  end
end
