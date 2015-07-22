class RemoveDonePercentFromUserSubjects < ActiveRecord::Migration
  def change
    remove_column :user_subjects, :done_percent, :float
  end
end
