# Setup our DB Connections
DataMapper.setup(:default, EcommerceApp.settings.database_url)

# Load all of our models
Dir[File.join(File.dirname(__FILE__), '/*.rb')].each { |f| require f }

# Finalize the DataMapper models.
DataMapper.finalize

# Tell DataMapper to update the database according to the definitions above.
DataMapper.auto_upgrade!
