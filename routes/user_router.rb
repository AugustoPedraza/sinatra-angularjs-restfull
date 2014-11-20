class UserRouter < Sinatra::Base
  before '/api/*' do
    content_type :json
  end

  post '/api/users' do
    user_credentials_params = JSON.parse(request.body.read)
    user  = User.new(user_credentials_params)

    if user.save
      response.headers['Authorization'] = ApiKey.create.token
      201 #Created resource
    else
      [400, { errors: user.errors.map(&:to_s) }.to_json]
    end
  end

end
