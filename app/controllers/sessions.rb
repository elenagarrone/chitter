get '/sessions/new' do
  @sign_in_page = true
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
