FactoryBot.define do
  factory :refund_transaction, class: "RefundTransaction", parent: :transaction do
    transaction_amount = Faker::Number.decimal(r_digits: 2)
    amount { transaction_amount }
    charge_transaction { create(:charge_transaction, amount: transaction_amount, status: :refunded) }
  end
end
