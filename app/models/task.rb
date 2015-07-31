class Task < ActiveRecord::Base
  belongs_to :subject
  has_many :user_tasks, dependent: :destroy
  after_create :update_user_tasks

  private
  def update_user_tasks
    self.subject.users.each do |user|
      UserTask.create user_id: user.id, task_id: self.id
    end
  end
end
