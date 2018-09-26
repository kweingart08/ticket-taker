class OrdersController < ApplicationController

  def index

    if params[:value_one]
      @orders = Order.set_filter(params[:value_one])
    else
      @orders = Order.all
    end

    @sum = Order.sum(:quantity)
    @revenue = Order.get_total_revenue(@orders)

  end


  def show
    @order = Order.find(params[:id])
  end

  def new
    @showtime = Showtime.find(params[:showtime_id])
    @order = Order.new
  end

  def create

    @order = Order.new({
      name: params[:order][:name],
      email: params[:order][:email],
      credit_card_number: params[:order][:credit_card_number],
      expiration_date: params[:order][:expiration_date],
      quantity: params[:order][:quantity].to_i,
      showtime_id: params[:showtime_id].to_i
      })

    if @order.save
      flash[:success] = "You have successfully ordered tickets!"

      redirect_to showtimes_path
    else
      render 'new'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_path
  end


  private def order_params
  params.require(:order).permit(:name, :email, :credit_card_number, :expiration_date, :quantity, :showtime_id)
end


end
