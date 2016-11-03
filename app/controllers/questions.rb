get '/questions' do
  @questions = Question.all.order(:title)
  erb :index
end

post '/questions' do
  require_login
  @question = Question.new(params[:question])
  @question.update(creator_id: current_user.id)
  if @question && @question.save
    status 200
    redirect "/questions/#{@question.id}"
  else
    status 400
    @errors = @question.errors.full_messages
    erb :'/questions/new'
  end
end

get '/questions/new' do
  require_login
  erb :'/questions/new'
end

get '/questions/:id' do
  @question = Question.find_by(id: params[:id])
  erb :'/questions/show'
end