FactoryBot.define do
  factory :market do
    name { Faker::Cosmere.allomancer }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    county { Faker::Cosmere.spren }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end
end
