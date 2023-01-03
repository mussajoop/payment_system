class Admin < User
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
