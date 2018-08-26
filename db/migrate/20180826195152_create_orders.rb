class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :credit_card_number
      t.date :expiration_date
      t.integer :quantity
      t.references :showtime, foreign_key: true

      t.timestamps
    end
  end
end
