# REGISTER
get '/users/new' do
  erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    puts "User saved!"
    redirect '/sessions/new'
  else
    @errors = @user.errors.full_messages
    puts "User not saved!"
    erb :'/users/new'
  end
end

# DASHBOARD
get '/users/:id' do
  if logged_in?
    erb :'users/show'
  else
    redirect '/sessions/new'
  end
end
