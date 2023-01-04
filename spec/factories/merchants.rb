FactoryBot.define do
  factory :merchant, class: "Merchant", parent: :user do
    trait :active do
      status { :active }
    end
  end
end
