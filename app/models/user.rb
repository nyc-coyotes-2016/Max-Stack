class User < ActiveRecord::Base
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create

  has_secure_password
  has_many :answers, foreign_key: :responder_id
  has_many :questions, foreign_key: :creator_id
  has_many :votes, foreign_key: :voter_id
  has_many :comments, foreign_key: :commenter_id
end
