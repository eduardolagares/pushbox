require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  subject { build(:subscription) }

  context 'associations' do
    should belong_to(:device)
    should belong_to(:topic)
  end
end
