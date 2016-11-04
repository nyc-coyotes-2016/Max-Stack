get '/questions/:id/answers/new' do
  require_login
  @question = Question.find_by(id: params[:id])
  erb :'/answers/new'
end

post '/questions/:id/answers' do
  require_login
  answer = Answer.new(params[:answer])
  if answer && answer.update(question_id: params[:id], responder_id: current_user.id)
    status 200
    redirect "/questions/#{params[:id]}"
  else
    status 400
    @question = Question.find_by(id: params[:id])
    @errors = answer.errors.full_messages
    erb :'/answers/new'
  end
end

get '/questions/:id/answers/:answer_id/edit' do
  require_login
  @question = Question.find_by(id: params[:id])
  @answer = Answer.find_by(id: params[:answer_id])
  if @answer.responder_id != current_user.id
      erb :'error_404'
  else
    erb :'/answers/edit'
  end
end

put '/questions/:id/answers/:answer_id' do
  require_login
  @question = Question.find_by(id: params[:id])
  @answer = Answer.find_by(id: params[:answer_id])
  if @answer.responder_id != current_user.id
      erb :'error_404'
  else
    if @answer && @answer.update(params[:answer])
      status 200
      redirect "/questions/#{@question.id}"
    else
      status 400
      @errors = @answer.errors.full_messages
      erb :'/answers/edit'
    end
  end
end

delete '/questions/:id/answers/:answer_id' do
  require_login
  if answer = Answer.find_by(id: params[:answer_id])
    if answer.responder_id == current_user.id
      answer.destroy
      status 200
      redirect "/questions/#{params[:id]}"
    else
      erb :'error_404'
    end
  else
    status 400
    @errors = ['delete unsuccessful']   #I forget if answer.errors.full_messages works with this one. Will try later, but hard coding a fail message should work for now.
    erb :'/questions/show'
  end
end
