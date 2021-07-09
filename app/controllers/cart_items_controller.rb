class CartItemsController < ApplicationController
  before_action :set_line_item, only: [:create, :destroy, :update]
  before_action :set_user
  before_action :set_cart

  def create
    @cart_item = @cart.cart_items.build(item_id: params[:item_id], quantity: params[:quantity], user_id: current_user .id)
    if @cart_item.save
      redirect_to cart_path(@cart_item.user)
    else
      redirect_to item_path(@cart_item.item)
    end
  end

  def destroy
    @cart.destroy
    redirect_to current_cart
  end

  # def update
  #   if @cart_item.update(item_id: params[:item_id], quantity: params[:quantity])
  #     redirect_to cart_path(@cart.user)
  #   else
  #     render item_path(@cart_item.item)
  #   end
  # end

  private
  def set_user
    @user = current_user
  end

  def set_line_item
    @cart_item = current_cart.cart_items.find_by(item_id: params[:item_id])
  end

  def set_cart
    @cart = current_cart
  end

  # def cart_item_set
  #   params.require(:item).permit(:item_id, :quantity)
  # end
end
