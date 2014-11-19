class ApiKey
  include DataMapper::Resource

  timestamps :at

  #Attributes
  property :id,           Serial,     key: true
  property :token,        String,     length: 32

  before :create, :generate_token

private
  def generate_token
    begin
      self.token = SecureRandom.hex
    end while self.class.count(:conditions => [ 'access_token = ?', access_token]) > 0 #To avoid collission
  end
end
