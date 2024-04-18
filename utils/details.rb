module Utils
  class Details
    def self.call(token, report)
      id = report[:id]
      format = report[:format]
      currency = report[:currency]
      reports = Client.new(:get).request("/reports/#{id}", {}, { Authorization: token })
      details = Utils::ReportStrategy.for(reports.body, format, currency)

      details.each do |data|
        TransactionJob.perform_async(data)
      end
    end
  end
end
