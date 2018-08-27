class OrderMailer < ApplicationMailer
  default from: 'orders@example.com'

  def new_order(order)
    @order = order

    mail(to: @order.email, subject: "Order Confirmation")
  end

end
