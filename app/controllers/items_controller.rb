class ItemsController < ApplicationController
  
  
  def index
    @items = Items.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if 
       @article.save
      redirect_to root_path
    else
      render :new
    end
  end
end



private
 def item_params
  params.require(:item).permit(:category_id,:image,:sales_status_id, :shipping_fee_status_id,:prefecture_id, :scheduled_delivery_id,:name,:info,:price ).merge(user_id: current_user.id)
 end