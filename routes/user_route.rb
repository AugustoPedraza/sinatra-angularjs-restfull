class UserRoute < Sinatra::Base
  before '/api/*' do
    content_type :json
  end

  post '/api/users/' do
    user_credentials_params = JSON.parse(request.body.read)
    user  = User.new(user_credentials_params)

    if user.save
      response.headers['Authorization'] = ApiKey.create
      201 #Created resource
    else
      puts "="*50
      user.errors.each do |e|
        p e
      end
      puts "="*50
      [400, { errors: user.errors.map(&:to_s) }.to_json]
    end
  end

end
