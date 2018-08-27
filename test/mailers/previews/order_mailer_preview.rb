# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  def new_order
    order = Order.last
    OrderMailer.new_order(order)
  end

end
