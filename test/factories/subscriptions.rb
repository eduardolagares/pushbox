FactoryBot.define do
  factory :subscription do
    topic { create(:topic) }
    device { create(:device) }
    # status { Subscription.statuses.values.sample }
    canceled { Faker::Boolean.boolean }
  end
end
