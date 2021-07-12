class CartsController < ApplicationController

  def show
    @cart_items = current_cart.user.cart_items
    @cart_count = 0
    @cart_total = 0
  end

end
