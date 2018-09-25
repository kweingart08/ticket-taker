ActiveAdmin.register_page "Dashboard" do

  menu priority: 1
  content title: proc{ I18n.t("active_admin.dashboard") } do
      columns do
        column do
          panel "Recent Orders" do
            table_for Order.limit(10) do
              column("Quantity") { |order| order.quantity}
              column("Movie") { |order| Showtime.find_by(id: order.showtime_id).movie.title}
              column("Order Total") { |order| number_to_currency order.quantity * order.showtime.price}
            end
          end
        end


    end #columns

    panel "Dashboard" do
      div do
        render("/admin/dashboard/orders_dashboard")
      end
    end
    
  end # content
end
