FactoryBot.define do
  factory :tag do
    label { Faker::Games::LeagueOfLegends.unique.champion }
    name { Faker::Games::LeagueOfLegends.champion }
  end
end
