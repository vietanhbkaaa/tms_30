class AddFinishedToUserSubject < ActiveRecord::Migration
  def change
    add_column :user_subjects, :finished, :boolean
  end
end
