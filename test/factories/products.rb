FactoryBot.define do
  factory :product do
    name { Faker::Movies::Hobbit.character }
    description { Faker::Movies::Hobbit.quote }
    price_in_cents { 10 * 100 }
    stock { rand(9) + 1 }
  end
end
