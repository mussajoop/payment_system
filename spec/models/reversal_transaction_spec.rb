require 'rails_helper'

RSpec.describe ReversalTransaction, type: :model do
  it { should belong_to(:authorize_transaction) }

  describe "Reversal transaction" do
    let(:authorize_transaction) { create(:authorize_transaction, :with_active_merchant) }

    it "should set authorization transaction status to reversed" do
      ReversalTransaction.reversal!(authorize_transaction:)
      authorize_transaction.reload
      expect(authorize_transaction.reversed?).to eq true
    end

    it "should return ReversalTransaction object" do
      transaction = ReversalTransaction.reversal!(authorize_transaction:)
      expect(transaction).to be_a ReversalTransaction
    end
  end
end
