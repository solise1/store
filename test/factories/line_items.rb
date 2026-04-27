FactoryBot.define do
  factory :line_item do
    product { create(:product) }
    quantity { rand(3) + 1 }
    price { Faker::Commerce.price }

    trait :with_cart do
      cart { create(:cart) }
    end

    trait :with_order do
      order { create(:order) }
    end
  end
end
