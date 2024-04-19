require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://localhost:6379" }
end

Sidekiq::Web.use Rack::Session::Cookie, secret: '123123123'
Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
  [username, password] == ['memo', 'password']
end

Sidekiq.strict_args!(false)
