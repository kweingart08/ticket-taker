class CreateShowtimes < ActiveRecord::Migration[5.2]
  def change
    create_table :showtimes do |t|
      t.datetime :time
      t.integer :tickets_sold
      t.decimal :price
      t.references :movie, foreign_key: true
      t.references :screen, foreign_key: true

      t.timestamps
    end
  end
end
