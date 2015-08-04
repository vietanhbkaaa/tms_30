class UserMailer < ApplicationMailer
  def assigned_into_course user, course
    @user = user
    @course = course
    mail to: user.email, subject: t("mail.subject.assigned_into_course")
  end

  def removed_from_course user, course
    @user = user
    @course = course
    mail to: user.email, subject: t("mail.subject.removed_from_course")
  end
end
