class RefundTransaction < Transaction
  belongs_to :charge_transaction, class_name: "ChargeTransaction", foreign_key: "parent_id"

  validates :amount, numericality: { greater_than: 0 }

  def self.refund!(args)
    ActiveRecord::Base.transaction do
      args[:charge_transaction].refunded!
      args[:merchant].refund!(args[:amount].to_d)
      create!(amount: args[:amount].to_d, merchant: args[:merchant], charge_transaction: args[:charge_transaction])
    end
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
