class SupervisorCourse < ActiveRecord::Base
  belongs_to :supervisor, class_name: "User", foreign_key: :user_id
  belongs_to :managing_course, class_name: "Course", foreign_key: :course_id
end
