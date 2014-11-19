require 'bundler/setup'

require 'sinatra/base'
require 'sinatra/config_file'

require 'data_mapper'
require 'json'


require_relative 'routes/init'

class EcommerceApp < Sinatra::Base
  register Sinatra::ConfigFile

  use Sample

  config_file 'config.yml'

  require_relative 'models/init'

  # start the server if ruby file executed directly
  run! if __FILE__ == $0
end
