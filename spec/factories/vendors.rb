FactoryBot.define do
  factory :vendor do
    name { Faker::Cosmere.allomancer }
    description { Faker::Address.street_address }
    contact_name { Faker::Address.city }
    contact_phone { Faker::Cosmere.spren }
    credit_accepted { Faker::Address.state }
  end
end
