FactoryBot.define do
  factory :charge_transaction, class: "ChargeTransaction", parent: :transaction do
    transaction_amount = Faker::Number.decimal(r_digits: 2)
    amount { transaction_amount }
    authorize_transaction { create(:authorize_transaction, amount: transaction_amount) }
  end
end
