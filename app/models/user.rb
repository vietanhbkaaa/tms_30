class User < ActiveRecord::Base
  include Logs

  devise :database_authenticatable, :rememberable, :trackable, :validatable
  has_many :user_courses, dependent: :destroy
  has_many :supervisor_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :subjects, through: :user_subjects
  has_many :tasks, through: :user_tasks
  has_many :courses, through: :user_courses
  has_many :managing_courses, through: :supervisor_courses
  scope :recent, ->{order created_at: :desc}
end
