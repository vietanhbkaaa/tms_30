class User < ActiveRecord::Base
  include Logs

  devise :database_authenticatable, :rememberable, :trackable, :validatable
  has_many :user_courses, dependent: :destroy
  has_many :supervisor_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :user_tasks, through: :user_subjects, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :subjects, through: :user_subjects
  has_many :tasks, through: :user_tasks
  has_many :courses, through: :user_courses
  has_many :managing_courses, through: :supervisor_courses
  scope :recent, ->{order created_at: :desc}
  scope :supervisors, ->{where("id in (SELECT user_id FROM supervisor_courses)")}

  def self.send_trainees_report
    User.supervisors.each do |supervisor|
      ReportAtEndOfDays.perform_async supervisor.id
    end
  end

  def classmate? user
    course = self.courses.active_course.first
    course.users.include? user unless course.nil?
  end
end
