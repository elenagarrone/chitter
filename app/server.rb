require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require './app/models/user'
require './app/models/peep'
require_relative './helpers/application'
require_relative 'data_mapper_setup'
require_relative 'controllers/application.rb'
require_relative 'controllers/peeps.rb'
require_relative 'controllers/users.rb'
require_relative 'controllers/sessions.rb'
require_relative 'controllers/request_password.rb'

use Rack::Flash, :sweep => true

enable :sessions
set :session_secret, 'super_secret'
set :public_folder, Proc.new{ File.join(root, '..', 'public') }
set :partial_template_engine, :erb
