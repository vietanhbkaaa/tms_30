class Subject < ActiveRecord::Base
  include Logs
  has_many :user_subjects, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :user_tasks, through: :tasks
  has_many :courses, through: :course_subjects
  has_many :users, through: :user_subjects
  scope :recent, ->{order created_at: :desc}

  accepts_nested_attributes_for :tasks, allow_destroy: true,
    reject_if: proc {|attribute| attribute[:name].blank?}
  validates :name, presence: Settings.subjects.is_present,
    length: {minimum: Settings.subjects.min_c, maximum: Settings.subjects.max_c}
end
