require 'rails_helper'

RSpec.describe "GET /merchants", type: :system do
  let(:admin) { create(:admin) }
  let!(:merchant) { create(:merchant) }
  before do
    sign_in admin
    visit merchants_path
  end

  it "should contain merchant edit and destroy links" do
    expect(page).to have_link("Edit this merchant", href: "/merchants/#{merchant.id}/edit")
    expect(page).to have_link("Destroy this merchant", href: "/merchants/#{merchant.id}")
  end

  it "should destroy merchant successfully if no transaction is currently associated" do
    visit merchant_path(merchant.id)

    click_on('Destroy this merchant')
    expect(Merchant.all).not_to include(merchant)
  end

  it "should not destroy merchant if a transaction is currently associated" do
    merchant = create(:merchant, :active)
    create(:authorize_transaction, merchant:)
    visit merchant_path(merchant.id)

    click_on('Destroy this merchant')
    expect(Merchant.all).to include(merchant)
    expect(page).to have_content("Unable to destroy: merchant is related to a payment transaction!")
  end
end
