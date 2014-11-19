require 'bcrypt'

class User
  include DataMapper::Resource

  attr_accessor :password, :password_confirmation
  timestamps :at

  property :id,             Serial,     :key => true
  property :username,       String,     :length => 4..30,      :unique => true,         :required => true
  property :crypted_pass,   String,     :length => 60..60,  :required => true,    :writer => :protected
  property :email,          String,     :length => 5..200,  :required => true,    :format => :email_address



  validates_presence_of :password, :password_confirmation, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?

  before :valid?, :crypt_password

 # check validity of password if we have a new resource, or there is a plaintext password provided
  def password_required?
    new? or password
  end

  # Hash the password using BCrypt
  def crypt_password
    self.crypted_pass = BCrypt::Password.create(password) if password
  end

  def crypted_pass
    if pass = super
      BCrypt::Password.new(pass)
    else
      :no_password
    end
  end

  def right_password?(password)
    crypted_pass == password
  end

  def self.valid_credentials?(username, password)
    target_username = username.to_s.downcase
    db_username = first(:conditions => ['lower(username) = ?', target_username])

    if db_username && db_username.right_password?(password)
      true
    else
      false
    end
  end
end
