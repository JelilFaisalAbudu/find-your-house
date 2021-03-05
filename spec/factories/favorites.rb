FactoryBot.define do
  factory :favorite do
    user { Faker::Number.within(range: 1..10) }
    house { Faker::Number.within(range: 1..10) }
  end
end
