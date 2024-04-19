class TransactionJob
  include Sidekiq::Job
  sidekiq_options queue: 'high'

  def perform(data)
    # High performance async processing with automatic queue cleaning
    # when unnique constraint error on external_id
    # No record is duplicated only updated when match rules
    ActiveRecord::Base.transaction do
      transaction = Transaction.find_by(external_id: data['external_id'])
      # Since there is no infor about duplicate external_id
      # The rules are
      # - Do nothing with transactions PARTIALLY_REFUNDED and REFUNDED
      # - Update transactions PENDING, PAID and VOID
      # - Create transaction if transaction does not exist
      return if transaction && ['PARTIALLY_REFUNDED','REFUNDED'].include?(transaction.status)

      if transaction && ['PENDING','PAID', 'VOID'].include?(transaction.status)
        transaction.update(data.stringify_keys)
      else
        Transaction.create(data.stringify_keys)
      end
    end
  end
end
