module Utils
  class List
    def self.call(token)
      reports_data = Client.new(:get).request("/reports", {}, { Authorization: token })
      reports_data.map { |report| { id: report['report_id'], format: report['format'], currency: report['symbol'] }}
    end
  end
end
