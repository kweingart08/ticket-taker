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


  # need to validate credit card

end
