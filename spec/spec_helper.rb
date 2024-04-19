ENV['APP_ENV'] = 'test'

require './models/transaction'
Dir["#{__dir__}/../lib/*.rb"].each {|file| require file }
Dir["#{__dir__}/../utils/*.rb"].each {|file| require file }
Dir["#{__dir__}/../jobs/*.rb"].each {|file| require file }

require 'rspec'
require 'vcr'
require 'webmock'
require 'rspec-sidekiq'
require 'sidekiq/testing'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec::Sidekiq.configure do |config|
  # Clears all job queues before each example
  config.clear_all_enqueued_jobs = true # default => true

  # Whether to use terminal colours when outputting messages
  config.enable_terminal_colours = true # default => true

  # Warn when jobs are not enqueued to Redis but to a job array
  config.warn_when_jobs_not_processed_by_sidekiq = true # default => true
end
