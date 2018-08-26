class Order < ApplicationRecord
  belongs_to :showtime

  # need to validate email and credit card
  validates :email, confirmation: true
  # need to check the expiration date is not earlier than today's date

end
