class RoutineExercise < ApplicationRecord
  belongs_to :routine_day
  belongs_to :exercise

  validates :target_sets, :target_reps, presence: true, numericality: { greater_than: 0 }
end
