class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  scope :finished, ->(subject){where subject_id: subject.id, finished: true}
end
