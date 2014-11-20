require 'bundler/setup'

require 'sinatra/base'
require 'sinatra/config_file'

require 'data_mapper'
require 'json'



class EcommerceApp < Sinatra::Base
  register Sinatra::ConfigFile

  config_file 'config.yml'

  require_relative 'models/init'
  require_relative 'routes/init'

  use UserRouter
  use SessionRouter
  use ProductRouter


  get '/' do
    erb :index
  end


  # start the server if ruby file executed directly
  run! if __FILE__ == $0
end
