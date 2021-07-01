class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_order, only: [:index, :create]
  before_action :index_action, only: [:index, :create]

  def index
    
    redirect_to new_card_path and return unless current_user.card.present?
    @order_address = OrderAddress.new
  end

  def create
     redirect_to new_card_path and return unless current_user.card.present?
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :municipality, :address, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
    Payjp::Charge.create(
      amount: @item.price,
      customer: customer_token, # 顧客のトークン
      currency: 'jpy'
    )
  end

  def set_order
    @item = Item.find(params[:item_id])
  end

  def index_action
    redirect_to root_path if current_user == @item.user || @item.order.present?
  end
end
