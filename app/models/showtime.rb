class Showtime < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  has_many :orders
end
