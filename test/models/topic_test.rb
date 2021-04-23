require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  subject { build(:topic) }

  context 'associations' do
    should have_many(:subscriptions)
  end

  context 'validations' do
    should validate_presence_of(:title)
  end
end
