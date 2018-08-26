class Order < ApplicationRecord
  belongs_to :showtime

  validates :name, :email, :credit_card_number, :expiration_date, :quantity, presence: true
  # need to validate email and credit card


  # need to check the expiration date is not earlier than today's date
  validate :expiration_date_cannot_be_in_the_past
  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end

end
