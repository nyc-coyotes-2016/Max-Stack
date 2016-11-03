class Question < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :answers
  has_many :votes, as: :voteable
  has_many :comments, as: :commentable
end
