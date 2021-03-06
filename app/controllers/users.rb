get '/users/new' do
  @sign_up_page = true
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
