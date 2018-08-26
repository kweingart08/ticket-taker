class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @showtime = Showtime.find(params[:showtime_id])
    @order = Order.new

    # render json: params[:showtime_id]
  end

  def create

    # render json: params[:order]
    # render json: params[:order][:name]
    # render json: params[:order][:quantity].to_i
    # expiration_date = params[:order][:expiration_date(2i)] + params[:order][:expiration_date(2i)]
    #
    # render plain: expiration_date
    @order = Order.new({
      name: params[:order][:name],
      email: params[:order][:email],
      credit_card_number: params[:order][:credit_card_number],
      expiration_date: params[:order][:expiration_date],
      quantity: params[:order][:quantity].to_i,
      showtime_id: params[:order][:showtime_id].to_i
      })

    if @order.save
      redirect_to showtime_orders_path
    else
      render 'new'
    end
  end


  private def order_params
  params.require(:order).permit(:name, :email, :credit_card_number, :expiration_date, :quantity, :showtime_id)
end


end
