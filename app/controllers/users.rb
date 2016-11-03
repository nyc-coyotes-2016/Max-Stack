# REGISTER
get '/users/new' do
  erb :'users/new'
end

post '/users' do
  user = User.new(params[:user])
  if user && user.save
    status 200
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    status 400
    @errors = user.errors.full_messages
    puts "User not saved!"
    erb :'/users/new'
  end
end

# DASHBOARD
get '/users/:id' do
    require_login
    erb :'users/show'
end
