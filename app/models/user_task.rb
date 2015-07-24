class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  scope :finished, ->{where finished: true}

end
