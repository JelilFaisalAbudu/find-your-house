FactoryBot.define do
  factory :house do
    name { Faker::Restaurant.name }
    type { Faker::Restaurant.type }
    description { Faker::Restaurant.description }
  end
end
