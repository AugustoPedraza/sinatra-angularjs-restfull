# Load all of our route files
Dir[File.join(File.dirname(__FILE__), '/*.rb')].each { |f| require f }
