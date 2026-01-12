class CreateRoutineDays < ActiveRecord::Migration[8.0]
  def change
    create_table :routine_days do |t|
      t.references :routine, null: false, foreign_key: true
      t.integer :day_of_week

      t.timestamps
    end
  end
end
