class Course < ActiveRecord::Base
  has_many :user_courses, dependent: :destroy
  has_many :supervisor_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :subjects, through: :course_subjects
  has_many :supervisors, through: :supervisor_courses
  scope :recent, ->{order created_at: :desc}
  
  validates :name, presence: Settings.courses.is_present,
    length: {minimum: Settings.courses.min_c, maximum: Settings.courses.max_c}

  def date_duration
    self.subjects.inject(0){|total_date, subject| total_date + subject.date_duration}
  end

  def has_trainee? user
    self.users.include? user
  end

  def has_supervisor? user
    self.supervisors.include? user
  end

  def has_member? user
    has_trainee?(user) || has_supervisor?(user)
  end
end
