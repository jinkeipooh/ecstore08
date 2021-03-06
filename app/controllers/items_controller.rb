class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only:[:show, :edit, :update, :destroy]
  before_action :move_to_index, only:[:edit, :update, :destroy]

  def index
    @items = Item.order("created_at DESC")
    @cart = current_cart
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to user_path(@item.user.id)
    else
      render :new
    end
  end

  def show
    @cart = current_cart
  end

  def edit
    @cart = current_cart
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to user_path
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless current_user.id == @item.user_id
      redirect_to action: :index
    end
  end


end
