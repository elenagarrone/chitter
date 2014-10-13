require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require_relative './helpers/application'
require_relative 'data_mapper_setup'

use Rack::Flash, :sweep => true

enable :sessions
set :session_secret, 'super_secret'

get '/' do
	@peeps = Peep.all:order => [:time_peep.asc] #not really working why???
	erb :index
end

post '/peeps' do
	peep = params["peep"]
	Peep.create(:message => peep)
	redirect to('/')
end


get '/users/new' do
	@user = User.new
	erb :"users/new"
end

post '/users' do
	@user = User.create(:email => params[:email],
				:password => params[:password],
				:password_confirmation => params[:password_confirmation],
				:name => params[:name],
				:username => params[:username])
	if @user.save
		session[:user_id] = @user.id
		redirect to ('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end

get '/sessions/new' do
	erb :"sessions/new"
end

post '/sessions' do
	username, password = params[:username], params[:password]
	@user = User.authenticate(username, password)
	if @user
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash[:errors] = ["The username or password is incorrect, try again."]
		erb :"sessions/new"
	end
end

delete '/sessions' do
	session.clear
	"Good bye!"
end

get '/request_password' do
  erb :"users/request_password"
end

post '/request_password' do
  email = params[:email]
  @user = User.first(:email => email)
  	if @user
  	  @user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
	  @user.password_token_timestamp = Time.now
	  @user.save
	  "Here is your token: #{@user.password_token}"
	else
	  flash[:errors] = ["Sorry, the user you've entered does not exist, try again."]
	  redirect to ('/request_password')
	end
end

get "/users/request_password/:token" do
	user = User.first(:password_token => params[:token])
	return redirect to ('/request_password') if !user# the token is in the db
	time_request = user.password_token_timestamp 
	if Time.now - time_request < 3600
		erb :"/users/new_password"
	else
		flash[:errors] = ["Sorry, this token is invalid. Please try again."]
		redirect to ('/request_password')
	# ask for a email password again
	end
end

post '/request_password/new_password' do
  "Hello World"
end

