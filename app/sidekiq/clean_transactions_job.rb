class CleanTransactionsJob
  include Sidekiq::Job

  def perform(*_args)
    Transaction.where("created_at < ?", Time.current - 1.hour).delete_all
  end
end
