class SessionRouter < Sinatra::Base
  before '/api/*' do
    content_type :json
  end

  post '/api/sessions' do
    user_credentials_params = JSON.parse(request.body.read, symbolize_names: true)

    if User.valid_credentials?(user_credentials_params[:username], user_credentials_params[:password])
      response.headers['Authorization'] = ApiKey.create.token
      201 #Created resource
    else
      [406, { errors: ["username or password invalid."] }.to_json]
    end
  end

end
