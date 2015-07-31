class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  scope :finished, ->(subject){where subject_id: subject.id, finished: true}

  after_create :init_user_tasks
  after_destroy :remove_user_tasks

  private
  def init_user_tasks
    self.subject.tasks.each do |task|
      UserTask.create user_id: self.user_id, task_id: task.id
    end
  end

  def remove_user_tasks
    self.subject.tasks.each do |task|
      UserTask.find_by(user_id: self.user_id, task_id: task.id).destroy
    end
  end
end
