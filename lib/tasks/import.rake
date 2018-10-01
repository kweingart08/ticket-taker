require 'csv'

namespace :import do

  desc "Import Orders from CSV"
  task orders: :environment do
    filename = File.join Rails.root, "orders.csv"
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
       order = Order.create(showtime_id: row["showtime_id"], email: row["email"], credit_card_number: row["credit_card_number"], expiration_date: row["expiration_date"], quantity: row["quantity"], name: row["name"])
       puts "#{name} - #{order.errors.full_messages.join(",")}" if order.errors.any?
       counter += 1 if order.persisted?
    end

    puts "Imported #{counter} orders"
  end
end
