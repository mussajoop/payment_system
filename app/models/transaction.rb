class Transaction < ApplicationRecord
  belongs_to :merchant

  enum :status, { approved: 0, reversed: 1, refunded: 2, error: 3 }

  default_scope { order(created_at: :asc) }
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
