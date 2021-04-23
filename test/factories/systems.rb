FactoryBot.define do
  factory :system do
    name { Faker::App.name }
    label { Faker::App.unique.name }
  end
end
