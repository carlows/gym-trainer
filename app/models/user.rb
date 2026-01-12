class User < ApplicationRecord
  validates :identifier, presence: true, uniqueness: true
  has_many :routines, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_one :chat, dependent: :destroy
end
