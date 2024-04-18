module Utils
  class Details
    def self.call(token, report)
      id = report[:id]
      format = report[:format]
      currency = report[:currency]
      reports = Client.new(:get).request("/reports/#{id}", {}, { Authorization: token })
      details = Utils::ReportStrategy.for(reports, format, currency)

      details.each do |data|
        Transaction.create(data)
      end
    end
  end
end
