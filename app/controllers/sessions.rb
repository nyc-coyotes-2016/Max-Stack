get '/sessions/new' do
  erb :'sessions/login'
end

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

get '/sessions/logout' do # this should be a DELETE, but could not style to  disable select
  session.clear
  redirect '/'
end
