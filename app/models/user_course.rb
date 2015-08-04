class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  after_create :init_user_subjects
  after_create :notify_assigned_email
  after_destroy :remove_user_subjects
  after_destroy :notify_unassigned_email

  private
  def init_user_subjects
    self.course.subjects.each do |subject|
      UserSubject.create user_id: self.user_id, subject_id: subject.id
    end
  end

  def remove_user_subjects
    self.course.subjects.each do |subject|
      UserSubject.find_by(user_id: self.user_id, subject_id: subject.id).destroy
    end
  end

  def notify_assigned_email
    EmailAssignTrainees.perform_async self.user_id, self.course_id
  end

  def notify_unassigned_email
    EmailUnassignTrainees.perform_async self.user_id, self.course_id
  end
end
