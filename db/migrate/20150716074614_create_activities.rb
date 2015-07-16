class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :type_action
      t.integer :target_id
      t.string :link

      t.timestamps null: false
    end
  end
end
