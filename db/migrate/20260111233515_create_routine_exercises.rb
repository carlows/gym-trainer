class CreateRoutineExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :routine_exercises do |t|
      t.references :routine_day, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :target_sets
      t.integer :target_reps

      t.timestamps
    end
  end
end
