ActiveAdmin.register Order do

  permit_params :name, :email, :credit_card_number, :expiration_date, :quantity, :showtime_id

  index do
    column :id
    column :name
    column :email
    column :movie do |order|
      order.showtime.movie.title
    end
    column 'Date' do |order|
      order.showtime.show_date
    end
    column 'Time' do |order|
      order.showtime.show_time
    end
    column :quantity
    column :order_total do |order|
      number_to_currency order.quantity * order.showtime.price
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :quantity
      row :showtime
    end
  end


  filter :showtime
  filter :name
  filter :email
  filter :quantity

end
