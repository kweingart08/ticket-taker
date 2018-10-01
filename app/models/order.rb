class Order < ApplicationRecord

  belongs_to :showtime

  validates :name, :email, :credit_card_number, :expiration_date, :quantity, presence: true
  validates :email, presence: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validate :expiration_date_cannot_be_in_the_past
  validate :valid_card

  after_save :update_tickets
  after_save :send_confirmation_email

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end


  def valid_card
    number = credit_card_number
    num_array = number.to_s.split("")
    reverse = num_array.reverse

    for i in 0...reverse.length
     if i % 2 != 0
       num = reverse[i].to_i
       new_num = num * 2
       reverse[i] = new_num.to_s
     end
    end
    new_array = reverse.join().split("").reverse

    sum = 0
    for i in 0...new_array.length
     sum += new_array[i].to_i
    end

    if sum % 10 != 0 || num_array.length != 16
      errors.add(:credit_card_number, ": Card Number Not Valid")
    end
  end


  def update_tickets
    # p "================"
    # p self
    new_tickets = Showtime.find(id=self.showtime_id).tickets_sold + self.quantity.to_i
    Showtime.find(id=self.showtime_id).update({
      tickets_sold: new_tickets
      })
  end

  def send_confirmation_email
    OrderMailer.new_order(self).deliver_now
  end

  def get_order_total
    self.quantity * self.showtime.price
  end

  def self.get_total_revenue(orders)
    revenue = 0
    orders.each do |order|
      quantity = order.quantity.to_i
      price = order.showtime.price.to_f
      sale = quantity * price
      revenue += sale
    end
    return revenue.round(2)
  end

  def self.set_filter(title)
    return Order.joins('LEFT JOIN showtimes ON orders.showtime_id = showtimes.id').joins('LEFT JOIN movies ON showtimes.movie_id = movies.id').where("title = '#{title}'")
  end

  def self.revenue_per_movie
    return Order.joins('LEFT JOIN showtimes ON orders.showtime_id = showtimes.id').joins('LEFT JOIN movies ON showtimes.movie_id = movies.id').group('title').sum('price*quantity')
  end

  def self.revenue_per_time
    return Order.joins('LEFT JOIN showtimes ON orders.showtime_id = showtimes.id').group("extract(hour from time) || ':' || extract(minute from time)").order("extract(hour from time) || ':' || extract(minute from time)").sum('price*quantity')
  end

  def self.revenue_per_day
    return Order.joins('LEFT JOIN showtimes ON orders.showtime_id = showtimes.id').group_by_day_of_week('time', format: "%a").sum('price*quantity')
  end

  def self.tickets_per_movie
    return Order.joins('LEFT JOIN showtimes ON orders.showtime_id = showtimes.id').joins('LEFT JOIN movies ON showtimes.movie_id = movies.id').group('title').sum('quantity')
  end

  def self.tickets_per_time
    return Order.joins('LEFT JOIN showtimes ON orders.showtime_id = showtimes.id').group("extract(hour from time) || ':' || extract(minute from time)").order("extract(hour from time) || ':' || extract(minute from time)").sum('quantity')
  end

end
