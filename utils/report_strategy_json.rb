module Utils
  class ReportStrategyJson < ReportAbstractStrategy
    def self.filter(data, currency)
      filter = []

      JSON.parse(data).each do |record|
        attributes = {
          intent_id: record['account']['referrence_id'],
          value_in_cents: record['value'],
          status: status_map(record['status']),
          external_id: record['id'],
          currency: currency,
          paid_at: record['paid_at']
        }
        filter << attributes
      end

      filter
    end
  end
end
