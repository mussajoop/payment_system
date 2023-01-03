class TransactionService
  class << self
    def method_missing(method_name, args)
      transaction_class = "#{method_name.to_s
        .gsub(/[^a-z]/, '')
        .capitalize}Transaction"
        .constantize
      transaction_class.send(method_name, args)
    end

    def respond_to_missing?(method_name, include_private = false)
      super
    end
  end
end
