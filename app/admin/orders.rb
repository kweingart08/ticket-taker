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
  column :credit_card_number
  column :showtime
  column :quantity
  column :order_total do |order|
    number_to_currency order.quantity * order.showtime.price
  end
  actions
end

end
