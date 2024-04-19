module Utils
  class ReportStrategy
    def self.for(data, format, currency)
      case format
      when "json"
        Utils::ReportStrategyJson.filter(data, currency)
      when "csv"
        Utils::ReportStrategyCsv.filter(data, currency)
      when "xml"
        []
      else
        raise "Format not supported"
      end
    end
  end
end
