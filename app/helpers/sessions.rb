def current_user
  @current_user || User.find_by(id: [:session_id])
end

def logged_in?
  current_user != nil
end

def require_login
  redirect '/sessions/login' unless logged_in?
end 
