FactoryBot.define do
  factory :market_vendors do
    association :market
    association :vendor
  end
end