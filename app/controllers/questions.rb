get '/questions' do
  @questions = Question.all.order(:title)
  erb :index
end

get '/questions/:id' do
  @question = Question.find_by(id: params[:id])
  erb :'/questions/show'
end
