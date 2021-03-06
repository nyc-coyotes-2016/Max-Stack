get '/questions' do
  @questions = Question.all.order(updated_at: :desc)
  erb :index
end

post '/questions' do
  require_login
  question = Question.new(params[:question])
  if question && question.update(creator_id: current_user.id)
    status 200
    redirect "/questions/#{question.id}"
  else
    status 400
    @errors = question.errors.full_messages
    erb :'/questions/new'
  end
end

get '/questions/new' do
  require_login
  erb :'/questions/new'
end

get '/questions/:id' do
  @question = Question.find_by(id: params[:id])
  @answers = @question.answers
  erb :'/questions/show'
end

get '/questions/:id/edit' do
  binding.pry
  require_login
  @question = Question.find_by(id: params[:id])
  if @question && @question.creator_id == current_user.id
    erb :'/questions/edit'
  else
    erb :'error_404'
  end
end

put '/questions/:id' do
  require_login
  question = Question.find_by(id: params[:id])
  if question
    if question.creator_id == current_user.id
      question.update(params[:question])
      status 200
      redirect "/questions/#{question.id}"
    else
      erb :'error_404'
    end
  else
    status 400
    @errors = question.errors.full_messages
    erb :'/questions/edit'
  end
end

delete '/questions/:id' do
  require_login
  @question = Question.find_by(id: params[:id])
  @answers = @question.answers
  if @question
    if @question.creator_id == current_user.id
      @question.destroy
      status 200
      redirect "/questions"
    else
      erb :'error_404'
    end
  else
    status 400
    @errors = ['delete was unsuccessful']
    erb :'/questions/show'
  end
end
