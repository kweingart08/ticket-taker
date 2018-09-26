ActiveAdmin.register_page "Dashboard" do

  menu priority: 1
  content title: proc{ I18n.t("active_admin.dashboard") } do
      columns do
        column do
          panel "Orders" do
            table_for Order.all do
              column("Movie") { |order| Showtime.find_by(id: order.showtime_id).movie.title}
              column("Quantity") { |order| order.quantity}
              column("Order Total") { |order| number_to_currency order.get_order_total }
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
