class AddDetailsToShowtimes < ActiveRecord::Migration[5.2]
  def change
    change_column_default :showtimes, :tickets_sold, 0
    change_column :showtimes, :price, :decimal, precision: 5, scale: 2
  end
end
