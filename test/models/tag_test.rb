require 'test_helper'

class TagTest < ActiveSupport::TestCase
  subject { build(:tag) }

  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:label)
    should validate_uniqueness_of(:label)
  end
end
