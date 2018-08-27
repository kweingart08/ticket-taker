class OrderMailer < ApplicationMailer

  def new_order(order)
    @order = order

    mail to: @order.email, subject: "Order Confirmation for #{@order.showtime.movie.title}"
  end

end
