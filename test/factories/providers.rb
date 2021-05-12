FactoryBot.define do
  factory :provider do
    name { Faker::App.name }
    config { {} }
    delivery_class_name { 'Pushbox::Delivery::Expo' }
    label { Faker::App.unique.name }
  end
end
