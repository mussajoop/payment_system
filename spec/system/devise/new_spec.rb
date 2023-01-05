require 'rails_helper'

RSpec.describe "users/sign_in", type: :system do
  let(:merchant) { create(:merchant, :active) }
  let(:admin) { create(:admin) }

  context "As a merchant" do
    it "should redirect to transactions page after successfull sign in" do
      visit root_path
      fill_in "Email", with: merchant.email
      fill_in "Password", with: "passer123"

      click_on "Log in"
      expect(page).to have_content "Signed in successfully."
      expect(page).to have_content "Merchant"
      expect(page).to have_content merchant.name
    end
  end

  context "As an admin" do
    it "should redirect to transactions page after successfull sign in" do
      visit root_path
      fill_in "Email", with: admin.email
      fill_in "Password", with: "passer123"

      click_on "Log in"
      expect(page).to have_content "Signed in successfully."
      expect(page).to have_content "Admin"
      expect(page).to have_content admin.name
    end
  end
end
