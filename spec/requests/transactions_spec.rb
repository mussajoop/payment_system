require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  describe "POST /transactions/payment.json" do
    let(:active_merchant) { create(:merchant, :active) }
    let(:inactive_merchant) { create(:merchant) }
    let(:parameters) do
      {
        transaction: {
          amount: Faker::Number.decimal(r_digits: 2),
          customer_email: Faker::Internet.safe_email,
          customer_phone: Faker::PhoneNumber.phone_number_with_country_code,
        },
      }
    end

    context "User not authenticated" do
      it "should return unauthorized error" do
        post payment_transactions_path(format: :json), params: parameters
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "User authenticated as merchant" do
      it "should process payment successfully with active merchant and return transaction with status approved" do
        basic_auth_token = ActionController::HttpAuthentication::Basic.encode_credentials(active_merchant.email, "passer123")
        post payment_transactions_path(format: :json), params: parameters, headers: { AUTHORIZATION: basic_auth_token }
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["status"]).to eq "approved"
      end

      it "should process payment with error when merchant is inactive and return transaction with status error" do
        basic_auth_token = ActionController::HttpAuthentication::Basic.encode_credentials(inactive_merchant.email, "passer123")
        post payment_transactions_path(format: :json), params: parameters, headers: { AUTHORIZATION: basic_auth_token }
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["status"]).to eq "error"
      end

      it "should contains exactly" do
        basic_auth_token = ActionController::HttpAuthentication::Basic.encode_credentials(active_merchant.email, "passer123")
        post payment_transactions_path(format: :json), params: parameters, headers: { AUTHORIZATION: basic_auth_token }
        json_response = JSON.parse(response.body).symbolize_keys
        expect(json_response.keys).to contain_exactly(:id, :amount, :status, :customer_email, :customer_phone, :merchant_id, :created_at, :updated_at, :parent_id)
      end
    end
  end
end
