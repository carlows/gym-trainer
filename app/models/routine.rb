class Routine < ApplicationRecord
  belongs_to :user
  has_many :routine_days, dependent: :destroy
  has_many :sessions, dependent: :nullify

  validates :name, presence: true

  scope :active, -> { where(archived: [ false, nil ]) }

  def archive!
    update!(archived: true)
  end
end
