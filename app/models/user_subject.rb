class UserSubject < ActiveRecord::Base
  include Logs
  VALUE_FOR_REJECT = "0"
  belongs_to :user
  belongs_to :subject
  has_many :user_tasks
  accepts_nested_attributes_for :user_tasks,
    reject_if: proc {|attribute| attribute[:finished] == VALUE_FOR_REJECT}
  scope :finished, ->subject{where subject_id: subject.id, finished: true}

  after_create :init_user_tasks
  after_update :finished_subject_activity
  after_destroy :remove_user_tasks

  private
  def init_user_tasks
    self.subject.tasks.each do |task|
      UserTask.create user_subject_id: self.id, task_id: task.id
    end
  end

  def finished_subject_activity
    create_activity Settings.logs.finished, user.id, self.id, subject.name
  end

  def remove_user_tasks
    self.subject.tasks.each do |task|
      UserTask.find_by(user_subject_id: self.id, task_id: task.id).destroy
    end
  end
end
