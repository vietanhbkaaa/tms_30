class User < ActiveRecord::Base
  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :activities, dependent: :destroy
end
