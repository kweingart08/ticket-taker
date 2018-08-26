class Movie < ApplicationRecord
  has_many :showtimes
  has_and_belongs_to_many :screens
  
  validates :title, presence: true
end
