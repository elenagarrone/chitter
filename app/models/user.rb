require 'bcrypt'

class User

	include DataMapper::Resource

	property :id, Serial
	property :email, String, :unique => true, :message => "This email is already teken"
	property :username, String, :unique => true, :message => "This username is already taken"
	property :password_digest, Text

	validates_uniqueness_of :email, :username

	def password=(password)
		self.password_digest = BCrypt::Password.create(password)
	end
end
