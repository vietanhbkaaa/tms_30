class UserTask < ActiveRecord::Base
  include Logs
  belongs_to :user_subject
  belongs_to :task

  scope :finished, ->{where finished: true}

  after_update :finished_task_activity

  private
  def finished_task_activity
    create_activity Settings.logs.finished, user_subject.user.id, self.id, task.name
  end
end
