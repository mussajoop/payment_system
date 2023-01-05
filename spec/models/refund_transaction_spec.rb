require 'rails_helper'

RSpec.describe RefundTransaction, type: :model do
  it { should belong_to(:charge_transaction) }

  describe "Refund transaction" do
    let(:authorize_transaction) { create(:authorize_transaction, :with_active_merchant) }
    let!(:charge_transaction) { create(:charge_transaction, authorize_transaction:) }

    it "charge transaction should be refunded" do
      RefundTransaction.refund!(charge_transaction.as_json.symbolize_keys.merge(merchant: charge_transaction.merchant, charge_transaction:))
      charge_transaction.reload
      expect(charge_transaction.status).to eq "refunded"
    end

    it "should decrease merchant total transactions" do
      merchant_total_transactions = charge_transaction.merchant.total_transaction_sum
      RefundTransaction.refund!(charge_transaction.as_json.symbolize_keys.merge(merchant: charge_transaction.merchant, charge_transaction:))
      charge_transaction.reload
      expect(charge_transaction.merchant.total_transaction_sum).to eq merchant_total_transactions - charge_transaction.amount
    end

    it "should return a RefundTransaction object" do
      transaction = RefundTransaction.refund!(charge_transaction.as_json.symbolize_keys.merge(merchant: charge_transaction.merchant, charge_transaction:))
      expect(transaction).to be_a RefundTransaction
    end
  end
end
