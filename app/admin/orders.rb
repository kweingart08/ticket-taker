ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :email, :credit_card_number, :expiration_date, :quantity, :showtime_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column :id
    column :name
    column :email
    column :movie do |showtime_id|
      @movie = Showtime.find(id=showtime_id.id).movie.title
    end
    column 'Date & Time' do |showtime_id|
      @time = Showtime.find(id=showtime_id.id).time
    end
    column :quantity
    column :order_total do |order|
      number_to_currency order.quantity * order.showtime.price
    end
    actions
  end

  controller do
    def create

    end
  end

  filter :showtime
  filter :name
  filter :email
  filter :quantity

end
