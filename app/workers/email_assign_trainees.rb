class EmailAssignTrainees
  include Sidekiq::Worker
  def perform user_id, course_id
    user = User.find user_id
    course = Course.find course_id
    UserMailer.assigned_into_course(user, course).deliver_now
  end
end
