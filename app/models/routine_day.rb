class RoutineDay < ApplicationRecord
  belongs_to :routine
  has_many :routine_exercises, dependent: :destroy

  enum :day_of_week, {
    monday: 0,
    tuesday: 1,
    wednesday: 2,
    thursday: 3,
    friday: 4,
    saturday: 5,
    sunday: 6
  }

  validates :day_of_week, presence: true
end
