require 'rails_helper'

RSpec.describe "/merchants/:id/edit", type: :system do
  let(:admin) { create(:admin) }
  let!(:merchant) { create(:merchant) }
  before do
    sign_in admin
    visit edit_merchant_path(merchant.id)
  end

  it "should contain merchant current info" do
    expect(page).to have_field('Name', with: merchant.name)
    expect(page).to have_field('Email', with: merchant.email)
    expect(page).to have_field('Description', with: merchant.description)
  end

  it "should edit merchant successfully" do
    custom_name = Faker::Name.name
    fill_in "Name", with: custom_name
    click_on "Save"
    merchant.reload
    expect(merchant.name).to eq custom_name
    expect(current_path).to eq merchant_path(merchant.id)
  end
end
