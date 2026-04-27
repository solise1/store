FactoryBot.define do
  factory :product do
    name { "Flower #{rand(100000)}" }
    description { Faker::Movies::Hobbit.quote }
    price { Faker::Commerce.price }
    stock { rand(3) + 1 }
  end
end
