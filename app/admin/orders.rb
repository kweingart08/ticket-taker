ActiveAdmin.register Order do

  permit_params :name, :email, :credit_card_number, :expiration_date, :quantity, :showtime_id

  index do

    panel 'Total Revenue' do
      number_to_currency Order.get_total_revenue(Order.all)
    end

    column :id
    column :name
    column :email
    column :movie, sortable: true do |order|
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
      number_to_currency order.get_order_total
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

  form do |f|
    f.inputs "New Order" do
      f.input :showtime
      f.input :name
      f.input :email
      f.input :credit_card_number
      f.input :expiration_date
      f.input :quantity

    end
    f.actions
  end

  filter :showtime, label: 'Movie Title', :collection => Movie.all.map { |m| [m.title]}
  filter :name
  filter :email
  filter :quantity

end
