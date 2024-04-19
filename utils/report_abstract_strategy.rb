module Utils
  class ReportAbstractStrategy
    def self.filter(data)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def self.status_map(status)
      case status
      when 'paid'
        'PAID'
      when 'partial_refund'
        'PARTIALLY_REFUNDED'
      end
    end
  end
end
