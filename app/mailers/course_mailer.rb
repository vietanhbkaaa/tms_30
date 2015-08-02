class CourseMailer < ApplicationMailer
  def course_info course, receiver
    @receiver = receiver
    @course = course
    @users = course.users
    mail to: receiver.email, subject: t("mail.subject.course_info")
  end

  def course_will_expire course, receiver
    @receiver = receiver
    @course = course
    mail to: receiver.email, subject: t("mail.subject.course_will_expire")
  end
end
