helpers do

  def current_user
		session_user_id = session[:user_id]
    @current_user ||= User.get(session_user_id) if session_user_id
  end

end
