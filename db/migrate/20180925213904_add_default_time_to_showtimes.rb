class AddDefaultTimeToShowtimes < ActiveRecord::Migration[5.2]
  def change
    change_column_default :showtimes, :time, DateTime.now.to_s
  end
end
