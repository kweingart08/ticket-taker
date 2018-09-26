class Showtime < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  has_many :orders

  after_destroy :remove_showtime

  def remove_showtime
    puts 'Showtime destroyed'
  end

  def show_date
    self.time.strftime('%A %b. %d, %Y')
  end

  def show_time
    self.time.strftime('%I:%M %p')
  end

  def tickets_left
    self.screen.capacity.to_i - self.tickets_sold.to_i
  end

end
