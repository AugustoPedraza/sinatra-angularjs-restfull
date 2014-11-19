require 'sinatra'
require 'json'
require 'dm-mysql-adapter'
require 'data_mapper'
require 'sinatra/config_file'

config_file 'config.yml'

#Setup datamapper
DataMapper.setup(:default, settings.database_url)

#require all files from /model
Dir[File.join(File.dirname(__FILE__), 'model/*.rb')].each { |f| require f }

# Finalize the DataMapper models.
DataMapper.finalize

# Tell DataMapper to update the database according to the definitions above.
DataMapper.auto_upgrade!

before '/api/*' do
  content_type :json
end

get '/api/hello' do
  { msg: 'Hello World!'}.to_json
end
