require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require './app/models/user'
require './app/models/peep'
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
	user = User.authenticate(username, password)
	if user
		session[:user_id] = user.id
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

