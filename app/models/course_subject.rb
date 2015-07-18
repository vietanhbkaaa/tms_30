class CourseSubject < ActiveRecord::Base
  belongs_to :course
  belongs_to :subject

  before_create {self.closed = true}
  after_create :init_user_subjects
  after_destroy :remove_user_subjects

  private
  def init_user_subjects
    self.course.users.each do |user|
      UserSubject.create user_id: user.id, subject_id: self.subject_id
    end
  end

  def remove_user_subjects
    self.course.users.each do |user|
      UserSubject.find_by(user_id: user.id, subject_id: self.subject_id).destroy
    end
  end
end
