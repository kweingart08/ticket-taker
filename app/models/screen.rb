class Screen < ApplicationRecord
  validates :room_number, :capacity, presence: true
end
