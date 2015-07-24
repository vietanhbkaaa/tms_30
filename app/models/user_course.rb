class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  after_create :supervisor_assign_trainee_activity
  before_destroy :supervisor_remove_trainee_activity

  private
  def supervisor_assign_trainee_activity
    create_activity "assign", self.user_id, self.user_id, self.name
  end

  def supervisor_remove_trainee_activity
    create_activity "remove", self.user_id, self.user_id, self.name
  end
end
