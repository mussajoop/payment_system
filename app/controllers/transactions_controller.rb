class TransactionsController < ApplicationController
  # GET /transactions
  def index
    authorize Transaction
    @transactions = Transaction.all_for_current_user(current_user)
  end

  # POST /transactions or /transactions.json
  def payment
    authorize Transaction
    @transaction = TransactionService.authorize!(transaction_params.merge(merchant: current_user))

    respond_to do |format|
      format.xml { render xml: @transaction }
      format.json { render json: @transaction }
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:uuid, :amount, :customer_email, :customer_phone)
  end
end
