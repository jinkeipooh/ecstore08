class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @items = Item.order("created_at DESC")
    @cart = current_cart
  end
end
