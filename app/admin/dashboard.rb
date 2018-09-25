ActiveAdmin.register_page "Dashboard" do

  menu priority: 1
  content title: proc{ I18n.t("active_admin.dashboard") } do
      columns do
        column do
          panel "Recent Orders" do
            table_for Order.limit(10) do
              column("Quantity") { |order| order.quantity}
            end
          end
        end

        column do
          panel "Dashboard" do
            div do
              render("/admin/dashboard/orders_dashboard")
            end
          end
        end
    end #columns

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
