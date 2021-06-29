class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show,:destroy,:edit,:update]
  before_action :redirect_user, only: [:edit, :update,:destroy]
  before_action :search_product, only: [:index, :tag_search]

  def index
    @items = Item.includes(:user).order('created_at DESC')
     set_item_column       # privateメソッド内で定義
  end

  def new
    @item_tag = ItemsTag.new
  end

  def create
   
    @item_tag = ItemsTag.new(item_params)
    if @item_tag.valid? 
      @item_tag.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @message = Message.new
    @messages = @item.messages.includes(:user)
  end

  def edit
    @item_tag = ItemsTag.new(item: @item)
  end

  def update
    
    @item_tag = ItemsTag.new(update_items_params, item: @item)
    if @item_tag.valid?
      @item_tag.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

   def tag_search
    binding.pry
   @results = @p.result  # 検索条件にマッチした商品の情報を取得
   end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private

  def update_items_params
    params.require(:item).permit(
      :tag_name,:category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id,
      :scheduled_delivery_id, :name, :info, :price,images: []).merge(user_id: current_user.id)
  end

  def item_params
    params.require(:item).permit(:tag_name,:category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id,
                                 :scheduled_delivery_id, :name, :info, :price,images: []).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])   
  end
  
   def set_item_column
    @item_name = Item.select("name").distinct
    end

  def redirect_user
    redirect_to root_path if @item.order.present? || current_user != @item.user
  end

   def search_product
    @p = Item.ransack(params[:q])  # 検索オブジェクトを生成
   end

end
