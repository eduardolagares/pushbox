FactoryBot.define do
  factory :device do
    external_identifier { Faker::App.name }
    provider_identifier { Faker::App.name }
    provider { create(:provider) }
    system { create(:system) }
    extra_data { Faker::Types.rb_hash }
    tags { Faker::Types.rb_array(len: 4) }
  end
end
