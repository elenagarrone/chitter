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
    flash[:errors] = ["The user you've entered does not exist, try again."]
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
  "Congratulation! Everything's done! ...more or less"
end
