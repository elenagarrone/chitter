post '/peeps' do
  @user = User.first(:id => session[:user_id])
  if @user
    peep = params["peep"]
    Peep.create(:message => peep, :user_id => @user.id)
    redirect to('/')
  else
    flash[:errors] = ["You need to sign in to post a peep"]
    redirect to ('/')
  end
end
