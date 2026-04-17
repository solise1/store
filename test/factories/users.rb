FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }

    factory :admin do
      role { :admin }
      after(:create) { |user| user.confirm }
    end
  end
end
