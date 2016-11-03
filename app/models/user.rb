class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :answers, foreign_key: :responder_id
  has_many :questions, foreign_key: :creator_id
  has_many :votes, foreign_key: :voter_id
  has_many :comments, foreign_key: :commenter_id
end
