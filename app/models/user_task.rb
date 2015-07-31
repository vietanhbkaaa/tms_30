class UserTask < ActiveRecord::Base
  belongs_to :user_subject
  belongs_to :task

  scope :finished, ->{where finished: true}

end
