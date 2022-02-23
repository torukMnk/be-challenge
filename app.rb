require_relative 'config/application'

class app < Sinatra::Base
  
  get "/" do
  	erb :index
  end

end