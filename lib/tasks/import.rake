require 'csv'

namespace :import do

  desc "Import Orders from CSV"
  task orders: :environment do
    filename = File.join Rails.root, "orders.csv"
    CSV.foreach(filename) do |row|
       showtime_id, email, credit_card_number, expiration_date, quantity, name = row
       Order.create(showtime_id: showtime_id, email: email, credit_card_number: credit_card_number, expiration_date: expiration_date, quantity: quantity, name: name)
    end
  end
end
