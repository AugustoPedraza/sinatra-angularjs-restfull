class ApiKey
  include DataMapper::Resource

  timestamps :at

  #Attributes
  property :id,           Serial,     key: true
  property :token,        String,     length: 32

  before :create, :generate_token

  def self.valid_token?(token = '')
    token != '' && count(:conditions => ['token = ?', token]) == 1
  end

private
  def generate_token
    begin
      self.token = SecureRandom.hex
    end while self.class.count(:conditions => [ 'token = ?', token]) > 0 #To avoid collission
  end
end
