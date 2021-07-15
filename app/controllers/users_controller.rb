class UsersController < ApplicationController
  def show
    @items = Item.order("created_at DESC")
    @cart = current_cart
  end
end
