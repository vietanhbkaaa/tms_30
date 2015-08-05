class ReportAtEndOfDays
  include Sidekiq::Worker
  def perform user_id
    user = User.find user_id
    ReportMailer.trainee_report_infomation(user).deliver_now
  end
end
