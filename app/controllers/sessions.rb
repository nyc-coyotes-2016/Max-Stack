# LOG IN PAGE
get '/sessions/new' do
  erb :'sessions/login'
end

# LOG IN POST
post '/sessions' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    puts "#{user.username} logged in. Redirecting."
    redirect '/questions'
  else
    @errors = ["Invalid email or password"]
    erb :'sessions/login'
  end
end

# LOG OUT
delete '/sessions/logout' do
  session.clear
  redirect '/'
end
