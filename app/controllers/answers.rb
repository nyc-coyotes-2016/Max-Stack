get '/questions/:id/answers/new' do
  require_login
  erb :'/answers/new'
end

post 'questions/:id/answers' do
  @answer = Answer.new(params[:answer])
  if @answer && @answer.update(question_id: params[:id], responder_id: current_user.id)
    status 200
    redirect "/questions/#{params[:id]}"
  else
    status 400
    @errors = @answer.errors.full_messages
    erb :'/answers/new'
  end
end
