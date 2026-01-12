class AddWeightToSessionExercises < ActiveRecord::Migration[8.0]
  def change
    add_column :session_exercises, :weight, :decimal
  end
end
