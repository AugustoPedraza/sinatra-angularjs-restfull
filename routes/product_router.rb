class ProductRouter < Sinatra::Base
  before '/api/products' do
    token = request.env["Http_Authorization".upcase]
    halt 401, [].to_json unless ApiKey.valid_token?(token)
  end

  get '/api/products' do
    Product.all.to_json
  end
end
