require_relative 'config/application'

class App < Sinatra::Base
  
  get "/" do
  	erb :index
  end

end