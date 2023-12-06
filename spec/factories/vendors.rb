FactoryBot.define do
  factory :vendor do
    name { Faker::Company.name }
    description { Faker::Fantasy::Tolkien.poem }
    contact_name { Faker::Fantasy::Tolkien.character }
    contact_phone { Faker::PhoneNumber.phone_number }
    credit_accepted { Faker::Boolean.boolean }
  end
end
