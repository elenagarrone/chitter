require 'bcrypt'

class User

	include DataMapper::Resource

	property :id, Serial
	property :email, String
	property :name, String
	property :username, String
	property :password_digest, Text

	attr_reader :password
	attr_accessor :password_confirmation

	validates_present :email, :message => "You need to enter an email address"
	validates_present :username, :message => "You need to enter a username"
	validates_present :name, :message => "You need to enter a name"
	validates_present :password, :message => "You need to enter a password"
	validates_uniqueness_of :username, :message => "This username is already taken"
	validates_uniqueness_of :email, :message => "This email is already teken"
	validates_confirmation_of :password, :message => "Sorry, your passwords don't match"
	validates_length :username, :in => (1..20)

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end
end
