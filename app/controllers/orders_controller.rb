class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order = Order.new
    @cart_items = current_cart.user.cart_items
    @cart_count = 0
    @cart_total = 0
    @cart_id = 0
  end

  def create
    @order = Order.create(order_params)
    if @order.save
      pay_item
      ###カートの中身を空にする処理 current_cart.destroy???  Cartコントローラーのdestroyアクションに飛ばせる？
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    # binding.pry
    params.require(:order).permit(:quantity, :total_price).merge(user_id: current_user.id, cart_id: params[:cart_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_params[:total_price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end

end
