class Order < ApplicationRecord
  belongs_to :showtime

  validates :name, :email, :credit_card_number, :expiration_date, :quantity, presence: true
  # need to validate email


  # need to check the expiration date is not earlier than today's date
  validate :expiration_date_cannot_be_in_the_past
  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end

  validates :email, presence: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i


  # using the luhn algorithm to detect valid card number
  validate :valid_card
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

  # need to validate credit card

end
