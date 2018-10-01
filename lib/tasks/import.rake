require 'csv'

namespace :import do

  desc "Import Orders from CSV"
  task orders: :environment do
    filename = File.join Rails.root, "orders.csv"
    counter = 0

    CSV.foreach(filename) do |row|
       showtime_id, email, credit_card_number, expiration_date, quantity, name = row
       order = Order.create(showtime_id: showtime_id, email: email, credit_card_number: credit_card_number, expiration_date: expiration_date, quantity: quantity, name: name)
       puts "#{name} - #{order.errors.full_messages.join(",")}" if order.errors.any?
       counter += 1 if order.persisted?
    end

    puts "Imported #{counter} orders"
  end
end
