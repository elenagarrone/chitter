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

	#validates_presence
	validates_uniqueness_of :username, :message => "This username is already taken"
	validates_uniqueness_of :email, :message => "This email is already teken"
	validates_confirmation_of :password, :message => "Sorry, your passwords don't match"

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end
end
