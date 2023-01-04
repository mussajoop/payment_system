FactoryBot.define do
  factory :authorize_transaction, class: "AuthorizeTransaction", parent: :transaction do
    amount { Faker::Number.decimal(r_digits: 2) }
  end
end
