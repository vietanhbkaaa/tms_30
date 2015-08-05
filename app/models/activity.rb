class Activity < ActiveRecord::Base
  FINISED_TASK = "finish_task"
  FINISED_SUBJECT = "finish_subject"
  belongs_to :user
  scope :recent, ->{order created_at: :desc}
  scope :reporting_news,
    ->{where("type_action IN (?, ?)", FINISED_TASK, FINISED_SUBJECT)}
end
