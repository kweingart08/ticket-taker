class Showtime < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  has_many :orders

  after_destroy :remove_showtime

  def remove_showtime
    puts 'Showtime destroyed'
  end
end
