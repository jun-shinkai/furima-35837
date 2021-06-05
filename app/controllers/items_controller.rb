class ItemsController < ApplicationController
  
  
  def index
    #@items = Items.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
     @item = Item.create(item_params)
  end
end


private
 def item_params
  params.require(:item).permit(:category_id,:image,:sales_status_id, :shipping_fee_status_id,:prefecture_id, :scheduled_delivery_id,:name,:info,:price ).merge(user_id: current_user.id)
 end