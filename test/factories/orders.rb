FactoryBot.define do
  factory :order do
    name { Faker::FunnyName.name }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }

    traits_for_enum :pay_type

    trait :with_line_items do
      transient do
        line_items_count { 1 }
      end

      line_items { Array.new(line_items_count) { association(:line_item, order: instance) } }
    end
  end
end
