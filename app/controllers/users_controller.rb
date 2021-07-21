class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @items = Item.order("created_at DESC")
    @cart = current_cart

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    redirect_to new_card_path and return unless card.present?
    customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first
  end
end
