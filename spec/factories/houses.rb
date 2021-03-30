FactoryBot.define do
  factory :house do
    name { Faker::Restaurant.name }
    category { Faker::Restaurant.type }
    description { Faker::Restaurant.description }
    photo_url { Faker::Internet.url }
  end
end
