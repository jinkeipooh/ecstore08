class CartsController < ApplicationController

  def show
    @cart_items = current_cart.user.cart_items
  end

end
