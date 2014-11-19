# Setup our DB Connections
DataMapper.setup(:default, settings.database_url)

# Load all of our models
Dir[File.join(File.dirname(__FILE__), '/*.rb')].each { |f| require f }
