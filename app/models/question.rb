class Question < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :answers
  has_many :votes, as: :voteable
  has_many :comments, as: :commentable

  validates :title, :body, :creator_id, presence: true
  validate :validates_creator_id

  def validates_creator_id
    errors.add(:creator_id, "does not exist") unless User.exists?(self.creator_id)
  end

  def creator
    self.creator_id == current_user.id
  end
end
