require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  subject { build(:notification) }

  context 'associations' do
    should belong_to(:provider)
    should belong_to(:destiny)
  end

  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:body_type)
  end
end
