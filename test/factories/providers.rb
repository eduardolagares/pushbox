FactoryBot.define do
  factory :provider do
    name { Faker::App.name }
    config { {} }
    delivery_class_name { Faker::App.name }
    synced_topics { Faker::Boolean.boolean }
    label { Faker::App.unique.name }
  end
end
