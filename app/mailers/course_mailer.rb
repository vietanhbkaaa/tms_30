class CourseMailer < ApplicationMailer
  def course_info course, receiver
    @receiver = receiver
    @course = course
    @users = course.users
    mail to: receiver.email, subject: t("mail.subject.course_info")
  end
end
