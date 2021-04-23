FactoryBot.define do
  factory :notification do
    provider { create(:provider) }
    destiny { create(:device) }
    title { Faker::Games::LeagueOfLegends.champion }
    subtitle { Faker::Games::LeagueOfLegends.quote }
    body { Faker::Games::LeagueOfLegends.quote }
    body_type { Notification.body_types.values.sample }
    tag { Faker::Games::LeagueOfLegends.champion }
  end
end
