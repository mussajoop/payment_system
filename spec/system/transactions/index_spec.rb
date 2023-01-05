require 'rails_helper'

RSpec.describe "GET /transactions", type: :system do
  let(:merchant) { create(:merchant, :active) }
  let(:admin) { create(:admin) }
  let!(:authorize_transaction_1) { create(:authorize_transaction, merchant:) }
  let!(:authorize_transaction_2) { create(:authorize_transaction) }

  context "Logged in as a merchant" do
    before do
      sign_in merchant
    end
    it "should show merchant transactions" do
      visit transactions_path
      within "#transactions" do
        expect(page).to have_content(authorize_transaction_1.id)
        expect(page).not_to have_content(authorize_transaction_2.id)
      end
    end

    it "should show error when trying to open merchants list link" do
      visit merchants_path
      expect(page).to have_content("Unauthorized action!")
      expect(current_path).not_to eq merchants_path
    end
  end

  context "Logged in as an admin" do
    before do
      sign_in admin
    end
    it "should show merchant transactions" do
      visit transactions_path
      within "#transactions" do
        expect(page).to have_content(authorize_transaction_1.id)
        expect(page).to have_content(authorize_transaction_2.id)
      end
    end

    it "should show error when trying to open merchants list link" do
      visit merchants_path
      expect(current_path).to eq merchants_path
    end
  end
end
