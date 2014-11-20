class Product
  include DataMapper::Resource

  property :id,           Serial,     :key => true
  property :name,         String,     :required => true
  property :price,        Float,      :required => true
  property :status,       Boolean,    :required => true
  property :description,  Text,       :required => true
end
