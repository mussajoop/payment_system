require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:merchant) }
  it { should validate_presence_of(:status) }
  describe "Transaction list" do
    let(:admin) { create(:admin) }
    let(:merchant) { create(:merchant, :active) }
    before do
      create_list(:transaction, 5)
      create(:transaction, merchant:)
      create(:transaction, merchant:)
    end

    it "should list all existing transactions if admin" do
      expect(Transaction.all_for_current_user(admin)).to eq Transaction.all
    end

    it "should list only user transactions if merchant" do
      expect(Transaction.all_for_current_user(merchant)).to eq Transaction.where(merchant:)
    end
  end
end
