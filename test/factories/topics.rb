FactoryBot.define do
  factory :topic do
    title { Faker::Games::LeagueOfLegends.champion }
    description { Faker::Games::LeagueOfLegends.quote }
    external_identifier { Faker::Games::LeagueOfLegends.champion }
  end
end
