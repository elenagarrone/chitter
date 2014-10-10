require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require './app/models/user'
require './app/helpers/application'

use Rack::Flash, :sweep => true

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './app/models/peep'

DataMapper.finalize

DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super_secret'

get '/' do
	@peeps = Peep.all#:order => [:order_peep.desc]
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

