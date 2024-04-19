require 'httparty'

class Client
  include HTTParty
  DEFAULT_HEADERS = { 'Accept': '*/*' }.freeze
  default_timeout 5

  def initialize(method)
    @method = method
  end

  def request(url, query, headers = {})
    case @method
    when :post
      self.class.post(endpoint(url), query: query, headers: headers.merge!(DEFAULT_HEADERS))
    when :get
      self.class.get(endpoint(url), query: query, headers: headers.merge!(DEFAULT_HEADERS))
    end
  end

  private

  def base_url
    @base_url ||= ENV['API_BASE_URL'] || 'https://be-challenge-uqjcnl577q-pd.a.run.app'
  end

  def endpoint(url)
    base_url + url
  end
end
