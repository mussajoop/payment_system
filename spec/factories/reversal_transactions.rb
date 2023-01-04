FactoryBot.define do
  factory :reversal_transaction, class: "ReversalTransaction", parent: :transaction do
    authorize_transaction { create(:authorize_transaction, amount: Faker::Number.decimal(r_digits: 2), status: :reversed) }
    status { :reversed }
  end
end
