require 'bcrypt'

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true, :message => "This email is already taken"
  property :name, String
  property :username, String, :unique => true, :message => "This username is already taken"
  property :password_digest, Text
  property :password_token, Text

  attr_reader :password
  attr_accessor :password_confirmation

  validates_presence_of :username, :message => "You need to enter a username"
	validates_length_of :username, :in => (1..20), :message => "Username must be between 1 and 20 characters long"
  validates_presence_of :name, :message => "You need to enter a name"
	validates_confirmation_of :password, :message => "Your passwords don't match"
	validates_length_of :password, :min => 6, :message => "Password needs to be of at least 6 characters"

	has n, :peeps

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(username, password)
		user = first(:username => username)
		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end

	# def sign_up(params)
	#   if(params[:password]  || params[:password_confirmation])
	#   user = User.create(:email => params[:email],
	# 			:password => params[:password],
	# 			:password_confirmation => params[:password_confirmation],
	# 			:name => params[:name],
	# 			:username => params[:username])
	#    user.save
	#    user
	#  end
end
