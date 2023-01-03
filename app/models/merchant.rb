class Merchant < User
  has_many :authorize_transactions, class_name: "AuthorizeTransaction", foreign_key: "merchant_id"
  has_many :charge_transactions, class_name: "ChargeTransaction", foreign_key: "merchant_id"
  has_many :refund_transactions, class_name: "RefundTransaction", foreign_key: "merchant_id"
  has_many :reversal_transactions, class_name: "ReversalTransaction", foreign_key: "merchant_id"

  def receive!(amount)
    self.total_transaction_sum += amount
    save!
  end

  def refund!(amount)
    self.total_transaction_sum -= amount
    save!
  end
end

# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  description           :string
#  email                 :string           not null
#  encrypted_password    :string           not null
#  name                  :string           not null
#  remember_created_at   :datetime
#  status                :integer          default("inactive"), not null
#  total_transaction_sum :decimal(, )      default(0.0), not null
#  type                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
