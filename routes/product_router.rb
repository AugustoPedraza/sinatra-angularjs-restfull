class ProductRouter < Sinatra::Base
  before '/api/products/*' do
    token = request.env["Http_Authorization".upcase]
    halt 401, { error: "Invalid token." }.to_json unless ApiKey.valid_token?(token)
  end

  # post '/api/products/' do
  #   user_credentials_params = JSON.parse(request.body.read)
  #   user  = User.new(user_credentials_params)

  #   if user.save
  #     response.headers['Authorization'] = ApiKey.create.token
  #     201 #Created resource
  #   else
  #     [400, { errors: user.errors.map(&:to_s) }.to_json]
  #   end
  # end

  get '/api/products' do
    Product.all.to_json
  end
end
