require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:authorize_transactions) }
  it { should have_many(:charge_transactions) }
  it { should have_many(:refund_transactions) }
  it { should have_many(:reversal_transactions) }

  describe "Merchant transactions" do
    let!(:merchant) { create(:merchant, :active) }

    it "should increase total transactions sum" do
      current_total = merchant.total_transaction_sum
      amount = Faker::Number.decimal(r_digits: 2)
      merchant.receive!(amount)
      expect(merchant.total_transaction_sum).to eq(current_total + amount)
    end

    it "should decrease total transactions sum" do
      current_total = merchant.total_transaction_sum
      amount = Faker::Number.decimal(r_digits: 2)
      merchant.refund!(amount)
      expect(merchant.total_transaction_sum).to eq(current_total - amount)
    end
  end
end
