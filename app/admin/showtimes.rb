ActiveAdmin.register Showtime do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :movie_id, :screen_id, :time, :tickets_sold, :price
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    column 'Showtime ID', :id
    column 'Date & Time', :time
    column :tickets_sold
    column :movie
    column :screen
    column :price do |ticket|
      number_to_currency ticket.price
    end
    actions
  end


  filter :id
  filter :time
  filter :movie, :as => :check_boxes

end
