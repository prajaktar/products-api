FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    price { Faker::Number.number(2) }
    quantity { Faker::Number.number(2) }
    association :category
  end
end