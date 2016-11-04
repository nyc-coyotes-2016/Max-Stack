def comment_router(comment)
  if comment.commentable_type == "Question"
    comment.commentable_id
  elsif comment.commentable_type == "Answer"
     answer = Answer.find_by(id: comment.commentable_id)
     question_id = answer.question.id
     question_id
   else
     @original_comment = comment
     until comment.commentable_type != "Comment"
       up_chain_comment_id = comment.commentable_id
       comment = Comment.find_by(id: up_chain_comment_id)
     end
     if comment.commentable_type == "Question"
       comment.commentable_id
     elsif comment.commentable_type == "Answer"
       answer = Answer.find_by(id: comment.commentable_id)
       question_id = answer.question.id
       question_id
     else
      FAIL
     end
   end
end
