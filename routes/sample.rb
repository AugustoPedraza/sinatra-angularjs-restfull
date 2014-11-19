class Sample < Sinatra::Base
  before '/api/*' do
    content_type :json
  end

  get '/api/hello' do
    { msg: 'Hello World!'}.to_json
  end

  get '/api/db' do
    { keys: ApiKey.all }.to_json
  end
end
