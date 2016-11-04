get '/questions/:id/answers/new' do
  require_login
  @question = Question.find_by(id: params[:id])
  if request.xhr?
    erb :'/answers/_new', layout: false
  else
    erb :'/answers/new'
  end
end



post '/questions/:id/answers' do
  require_login
  @question = Question.find_by(id: params[:id])
  @answer = Answer.new(params[:answer])
  if @answer && request.xhr?
    @answer.update(question_id: params[:id], responder_id: current_user.id)
    status 200
    erb :'/answers/_show', layout: false, locals: {answer: @answer, question: @question }
  elsif @answer
    @answer.update(question_id: params[:id], responder_id: current_user.id)
    status 200
    redirect "/questions/#{params[:id]}"
  elsif request.xhr?
    status 400
    @errors = @answer.errors.full_messages.to_json
  else
    status 400
    @errors = @answer.errors.full_messages
    erb :'/answers/new'
  end
end

get '/questions/:id/answers/:answer_id/edit' do
  require_login
  @question = Question.find_by(id: params[:id])
  @answer = Answer.find_by(id: params[:answer_id])
  if @answer.responder_id == current_user.id && request.xhr?
    erb :'/answers/_edit', layout: false, locals: { answer: @answer }
  elsif @answer.responder_id == current_user.id
    erb :'/answers/edit'
  else
    erb :'error_404'
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
  @question = Question.find_by(id: params[:id])
  @answers = @question.answers
  answer = @answers.find_by(id: params[:answer_id])
  if answer && request.xhr?
    if answer.responder_id == current_user.id
      answer.destroy
      status 200

      content_type :json
      { answer_id: params[:answer_id] }.to_json
    end
  elsif request.xhr?
    status 400
    @errors = { error: 'delete unsuccessful' }.to_json
  else
    status 400
    @errors = answer.errors.full_messages
    erb :'/questions/show'
  end
end
