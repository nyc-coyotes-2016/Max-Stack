class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :voter, class_name: 'User'

  def creator
    self.voter_id == current_user.id
  end
end
