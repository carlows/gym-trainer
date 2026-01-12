class CreateExercises < ActiveRecord::Migration[8.0]
  def change
    create_table :exercises do |t|
      t.string :name
      t.text :description
      t.string :exercise_type
      t.string :body_part
      t.string :equipment

      t.timestamps
    end
  end
end
