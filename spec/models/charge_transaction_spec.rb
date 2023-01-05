require 'rails_helper'

RSpec.describe ChargeTransaction, type: :model do
  it { should belong_to(:authorize_transaction) }

  describe "Charge transaction" do
    let(:authorize_transaction) { create(:authorize_transaction, :with_active_merchant) }

    it "should create a reversal transaction and set authorize transaction to reversed" do
      merchant = authorize_transaction.merchant
      transaction = ChargeTransaction.charge!(authorize_transaction.as_json.symbolize_keys.merge(merchant:, authorize_transaction:, amount: -1))
      expect(transaction).to be_a ReversalTransaction
      authorize_transaction.reload

      expect(authorize_transaction.status).to eq "reversed"
    end

    it "should create a charge transaction and increase merchant total transactions" do
      merchant = authorize_transaction.merchant
      merchant_total_transactions = merchant.total_transaction_sum
      ChargeTransaction.charge!(authorize_transaction.as_json.symbolize_keys.merge(merchant:, authorize_transaction:))
      authorize_transaction.reload

      expect(authorize_transaction.merchant.total_transaction_sum).to eq merchant_total_transactions + authorize_transaction.amount
    end
  end
end
