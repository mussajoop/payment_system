class AuthorizeTransaction < Transaction
  before_create :set_status
  validates :customer_email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :amount, numericality: { greater_than: 0 }

  def self.authorize!(args)
    authorize_transaction = create!(amount: args.fetch(:amount).to_d, customer_email: args[:customer_email], customer_phone: args[:customer_phone], merchant: args[:merchant])
    ChargeTransaction.charge!(args.merge(authorize_transaction:)) if args[:merchant].active?
    authorize_transaction
  end

  private

  def set_status
    self.status = "error" if merchant.inactive?
  end
end

# == Schema Information
#
# Table name: transactions
#
#  id             :uuid             not null, primary key
#  amount         :decimal(, )
#  customer_email :string
#  customer_phone :string
#  status         :integer          default("approved"), not null
#  type           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  merchant_id    :bigint           not null
#  parent_id      :uuid
#
# Indexes
#
#  index_transactions_on_merchant_id  (merchant_id)
#  index_transactions_on_parent_id    (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (merchant_id => users.id)
#  fk_rails_...  (parent_id => transactions.id)
#
