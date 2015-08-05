class ReportMailer < ApplicationMailer
  def trainee_report_infomation receiver
    @receiver = receiver
    mail to: receiver.email, subject: t("mail.subject.removed_from_course")
  end
end
