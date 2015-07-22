class RemoveSupervisorFromUserCourses < ActiveRecord::Migration
  def change
    remove_column :user_courses, :supervisor, :boolean
  end
end
