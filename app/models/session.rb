class Session < ApplicationRecord
  belongs_to :user
  belongs_to :routine
  has_many :session_exercises, dependent: :destroy
end
