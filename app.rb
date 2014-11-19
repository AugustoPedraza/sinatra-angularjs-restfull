require 'bundler/setup'

require 'sinatra/base'
require 'sinatra/config_file'

require 'json'

require_relative 'routes/init'

class EcommerceApp < Sinatra::Base
  register Sinatra::ConfigFile

  use Sample

  config_file 'config.yml'

  # start the server if ruby file executed directly
  run! if __FILE__ == $0
end
