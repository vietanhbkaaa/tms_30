class RemoveDonePercentFromUserCourses < ActiveRecord::Migration
  def change
    remove_column :user_courses, :done_percent, :float
  end
end
