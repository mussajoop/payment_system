class TransactionPolicy < ApplicationPolicy
  def index?
    user.admin? || user.merchant?
  end

  def payment?
    user.merchant?
  end
end
