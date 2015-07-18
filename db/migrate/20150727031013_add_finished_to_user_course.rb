class AddFinishedToUserCourse < ActiveRecord::Migration
  def change
    add_column :user_courses, :finished, :boolean
  end
end
