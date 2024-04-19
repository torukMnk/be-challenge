require 'pry'
require_relative 'client'
require 'thread/pool'

class AuthenticationError < StandardError
end

class Report
  EMAIL = 'guillermoq@test.com'
  PASSWORD = 'password'
  TOKEN = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.ETUYUOkmfnWsWIvA8iBOkE2s1ZQ0V_zgnG_c4QRrhbg'

  def self.fetch!
    auth = Client.new(:post).request("/login", { email: EMAIL, password: PASSWORD }, { Authorization: TOKEN })

    raise AuthenticationError unless auth.code == 200

    token = auth.parsed_response['token']
    reports = Utils::List.call(token)

    reports.each do |report|
      Utils::Details.call(token, report)
    end
  end

  def self.fetch_async!
    auth = Client.new(:post).request("/login", { email: EMAIL, password: PASSWORD }, { Authorization: TOKEN })

    raise AuthenticationError unless auth.code == 200

    pool = Thread.pool(5)
    token = auth.parsed_response['token']
    reports = Utils::List.call(token)

    reports.each { |report|
      pool.process {
        Utils::Details.call(token, report)
      }
    }

    pool.shutdown
  end
end
