################# NEW COMMENTS

get '/questions/:question_id/comments/new' do
  require_login
  @question = Question.find_by(id: params[:question_id])
  erb :'/comments/new'
end

post '/questions/:question_id/comments' do
  require_login
  comment = Comment.new(params[:comment])
  if comment && comment.update(commentable_id: params[:question_id], commentable_type:"Question", commenter_id: current_user.id)
    status 200
    redirect "/questions/#{params[:question_id]}"
  else
    status 400
    @question = Question.find_by(id: params[:id])
    @errors = comment.errors.full_messages
    erb :'/comments/new'
  end
end

get '/answers/:answer_id/comments/new' do
  require_login
  @answer = Answer.find_by(id: params[:answer_id])
  erb :'/comments/new'
end

post '/answers/:answer_id/comments' do
  require_login
  comment = Comment.new(params[:comment])
  if comment && comment.update(commentable_id: params[:answer_id], commentable_type:"Answer", commenter_id: current_user.id)
    status 200
    answer = Answer.find_by(id: params[:answer_id])
    puts "======================================"
    puts answer
    puts answer.question_id
    puts "======================================"
    redirect "/questions/#{answer.question_id}"
  else
    status 400
    @answer = Answer.find_by(id: params[:id])
    @errors = comment.errors.full_messages
    erb :'/comments/new'
  end
end

################# EDITING COMMENTS

get '/questions/:question_id/comments/:id/edit' do
  @question = Question.find_by(id: params[:question_id])
  @comment = Comment.find_by(id: params[:id])
  erb :'comments/edit'
end
put '/questions/:question_id/comments/:id' do
  require_login
  @question = Question.find_by(id: params[:question_id])
  @comment = Comment.find_by(id: params[:id])
  if @comment.commenter_id != current_user.id
      erb :'error_404'
  else
    if @comment && @comment.update(params[:comment])
      status 200
      redirect "/questions/#{@question.id}"
    else
      status 400
      @errors = @comment.errors.full_messages
      erb :'/comments/edit'
    end
  end
end

get '/answers/:answer_id/comments/:id/edit' do
  @answer = Answer.find_by(id: params[:answer_id])
  @comment = Comment.find_by(id: params[:id])
  erb :'comments/edit'
end
put '/answers/:answer_id/comments/:id' do
  require_login
  @answer = Answer.find_by(id: params[:answer_id])
  @comment = Comment.find_by(id: params[:id])
  if @comment.commenter_id != current_user.id
      erb :'error_404'
  else
    if @comment && @comment.update(params[:comment])
      status 200
      redirect "/questions/#{@answer.question_id}"
    else
      status 400
      @errors = @comment.errors.full_messages
      erb :'/comments/edit'
    end
  end
end

############## DELETING COMMENTS

delete '/questions/:question_id/comments/:id' do
  require_login
  if comment = Comment.find_by(id: params[:id])
    if comment.commenter_id == current_user.id
      comment.destroy
      status 200
      redirect "/questions/#{params[:question_id]}"
    else
      erb :'error_404'
    end
  else
    status 400
    @errors = ['delete unsuccessful']   #I forget if answer.errors.full_messages works with this one. Will try later, but hard coding a fail message should work for now.
    erb :'/questions/show'
  end
end

delete '/answers/:answer_id/comments/:id' do
  require_login
  answer = Answer.find_by(id: params[:answer_id])
  if comment = Comment.find_by(id: params[:id])
    if comment.commenter_id == current_user.id
      comment.destroy
      status 200
      redirect "/questions/#{answer.question_id}"
    else
      erb :'error_404'
    end
  else
    status 400
    @errors = ['delete unsuccessful']   #I forget if answer.errors.full_messages works with this one. Will try later, but hard coding a fail message should work for now.
    erb :'/questions/show'
  end
end
