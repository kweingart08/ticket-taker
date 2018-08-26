class Screen < ApplicationRecord
  has_many :showtimes
  has_and_belongs_to_many :movies
  has_many :orders, through: :showtimes

  validates :room_number, :capacity, presence: true
end
