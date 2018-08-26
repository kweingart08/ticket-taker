class Movie < ApplicationRecord
  has_many :showtimes
  has_and_belongs_to_many :screens
  has_many :orders, through: :showtimes

  validates :title, presence: true
end
