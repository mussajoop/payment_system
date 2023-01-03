class ChargeTransaction < Transaction
  belongs_to :authorize_transaction, class_name: "AuthorizeTransaction", foreign_key: "parent_id"

  before_create :set_status

  def self.charge!(args)
    ActiveRecord::Base.transaction do
      create!(amount: args[:amount], authorize_transaction: args[:authorize_transaction], merchant: args[:merchant])
      args[:merchant].receive!(args[:amount]) if args[:authorize_transaction].approved?
    rescue
      ReversalTransaction.reversal!(args.merge(authorize_transaction: args[:authorize_transaction]))
    end
  end

  private

  def set_status
    self.status = "error" unless authorize_transaction.approved?
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
