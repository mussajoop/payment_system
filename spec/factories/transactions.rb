FactoryBot.define do
  factory :transaction do
    amount { Faker::Number.decimal(r_digits: 2) }
    customer_email { Faker::Internet.safe_email }
    customer_phone { Faker::PhoneNumber.phone_number_with_country_code }
    merchant { create(:merchant) }
    trait :with_active_merchant do
      merchant { create(:merchant, :active) }
    end
  end
end
