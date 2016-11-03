class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :responder, class_name: 'User'
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  validates :text, :question_id, :responder_id, presence: true
  validates :text, length: { minimum: 10 }
  validate :validates_question_id, :validates_responder_id

  def validates_responder_id
    errors.add(:responder_id, "does not exist") unless User.exists?(self.responder_id)
  end

  def validates_question_id
    errors.add(:question_id, "does not exist") unless Question.exists?(self.question_id)
  end

  def answer_author
    self.responder.username
  end
end
