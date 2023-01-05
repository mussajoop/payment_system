require 'rails_helper'

RSpec.describe AuthorizeTransaction, type: :model do
  describe "Authorize transaction" do
    let!(:active_merchant) { create(:merchant, :active) }
    let!(:inactive_merchant) { create(:merchant) }
    let(:approved_transaction) { build(:authorize_transaction) }
    let(:transaction_with_error) { build(:authorize_transaction) }

    it "should create authorize transaction with status approved" do
      transaction = AuthorizeTransaction.authorize!(approved_transaction.as_json.symbolize_keys.merge(merchant: active_merchant))
      expect(transaction.status).to eq "approved"
    end

    it "should create authorize transaction with status error" do
      transaction = AuthorizeTransaction.authorize!(approved_transaction.as_json.symbolize_keys.merge(merchant: inactive_merchant))
      expect(transaction.status).to eq "error"
    end
  end
end
