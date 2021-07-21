class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @order = Order.new
    @cart_items = current_cart.user.cart_items
    @cart_count = 0
    @cart_total = 0
    @cart_id = 0

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    redirect_to new_card_path and return unless card.present?
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first

  end

  def create
    @order = Order.create(order_params)
    if @order.save
      pay_item
      ###カートの中身を空にする
      @cart_items = CartItem.where(user_id: current_user)
      @cart_items.destroy_all
      @cart = current_cart
    else
      @cart_items = current_cart.user.cart_items
      @cart_count = 0
      @cart_total = 0
      @cart_id = 0
      render :index
    end
  end

  private
  def order_params
    params.require(:order).permit(:quantity, :total_price).merge(user_id: current_user.id, cart_id: params[:cart_id])
  end

  def pay_item
    redirect_to new_card_path and return unless current_user.card.present?
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
    Payjp::Charge.create(
      amount: order_params[:total_price],
      # card: order_params[:token],
      customer: customer_token, # 顧客のトークン
      currency: 'jpy'
    )
  end

end
