module Utils
  class ReportStrategy
    def self.for(data, format, currency)
      case format
      when "json"
        Utils::ReportStrategyJson.filter(data, currency)
      else
        raise "Format not supported"
      end
    end
  end
end
