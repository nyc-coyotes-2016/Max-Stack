class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :voter, class_name: 'User'
end
