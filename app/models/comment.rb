class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: 'User'
  has_many :votes, as: :voteable

  def creator
    self.commenter_id == current_user.id
  end
end
