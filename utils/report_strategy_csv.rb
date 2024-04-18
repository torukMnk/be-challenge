module Utils
  class ReportStrategyCsv < ReportAbstractStrategy
    def self.filter(data, currency)
      filter = []
      csv = CSV.parse(data, headers: true)

      csv.each do |record|
        attributes = {
          intent_id: record['account_external_ref'],
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
