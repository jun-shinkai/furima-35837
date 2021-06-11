class ItemsController < ApplicationController
  before_action :authenticate_user!, expect: [:index,:show]
  before_action :set_item, except: [:index, :new, :create]
  before_action :redirect_user, only: [:edit, :update, :destroy]
  before_action :order_present, only: [:edit,:update,:destroy]
  
  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show and return
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :image, :sales_status_id, :shipping_fee_status_id, :prefecture_id,
                                 :scheduled_delivery_id, :name, :info, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_user
    redirect_to root_path if @item.order.present? || current_user != @item.user
  end
  def order_present
    if @item.order.present?
       redirect_to  root_path
    end
  end
end
