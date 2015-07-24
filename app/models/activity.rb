class Activity < ActiveRecord::Base
  belongs_to :user
  scope :recent, ->{order created_at: :desc}
end
