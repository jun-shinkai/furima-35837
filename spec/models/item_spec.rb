require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context'商品出品ができるとき' do
      it '商品の情報が正常であれば登録できる' do
        expect(@item).to be_valid
     end
    end
  
    
    context'商品出品がができないとき' do
     it 'imageが空だと登録できない' do
       @item.image= nil
       @item.valid?
       expect(@item.errors.full_messages).to include "Image can't be blank"
      end
     it 'nameが空では登録できない' do
       @item.name =''
       @item.valid?
       expect(@item.errors.full_messages).to include "Name can't be blank"
     end
     it 'infoが空では登録できない' do
       @item.info =''
       @item.valid?
       expect(@item.errors.full_messages).to include "Info can't be blank"
     end
     it 'category_idは、が存在しなければ登録できない。' do
       @item.category_id=""
       @item.valid?
       expect(@item.errors.full_messages).to include "Category can't be blank"
     end
     
     it 'sales_status_id が空では登録できない' do
       @item.sales_status_id =''
       @item.valid?
       expect(@item.errors.full_messages).to include "Sales status can't be blank"
      end
     it 'shipping_fee_status_idが空だと登録できない' do
      @item.shipping_fee_status_id =''
      @item.valid?
      expect(@item.errors.full_messages).to include "Shipping fee status can't be blank"
     end
     it 'shipping_fee_status_idが空だと登録できない' do
       @item.shipping_fee_status_id =''
       @item.valid?
       expect(@item.errors.full_messages).to include "Shipping fee status can't be blank"
     end
     it ' prefecture_idが空だと登録できない' do
       @item.prefecture_id=''
       @item.valid?
       expect(@item.errors.full_messages).to include "Prefecture can't be blank"
     end
     it 'scheduled_delivery_id ' do
       @item.scheduled_delivery_id =''
       @item.valid?
       expect(@item.errors.full_messages).to include "Scheduled delivery can't be blank"
     end
     it 'price が空だと登録できない' do
       @item.price    =''
       @item.valid?
       expect(@item.errors.full_messages).to include "Price can't be blank"
     end
     it 'price が300以下だと登録できない' do
      @item.price    = 299
      @item.valid?
      expect(@item.errors.full_messages).to include "Price must be greater than 300"
    end
    it 'price が9,999,999以上だと登録できない' do
      @item.price    ='10000000'
      @item.valid?
      expect(@item.errors.full_messages).to include "Price must be less than 10000000"
    end
    it 'price が半角数字以外だと登録できない' do
      @item.price    ='fwrfw'
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is not a number"
    end
     it 'category_id が0だと登録できない' do
       @item.category_id     = 0
       @item.valid?
       expect(@item.errors.full_messages).to include "Category must be other than 0"
     end
     it 'sales_status_id が0だと登録できない' do
       @item.sales_status_id    = 0
       @item.valid?
       expect(@item.errors.full_messages).to include "Sales status must be other than 0"
     end
     it 'shipping_fee_status_id が0だと登録できない' do
       @item.shipping_fee_status_id     = 0
       @item.valid?
       expect(@item.errors.full_messages).to include "Shipping fee status must be other than 0"
     end
     it 'prefecture_id  が0だと登録できない' do
       @item.prefecture_id      = 0
       @item.valid?
       expect(@item.errors.full_messages).to include "Prefecture must be other than 0"
     end
     it 'scheduled_delivery_id が0だと登録できない' do
       @item.scheduled_delivery_id     = 0
       @item.valid?
       expect(@item.errors.full_messages).to include "Scheduled delivery must be other than 0"
     end
     it 'ユーザーが紐付いていなければ投稿できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
   end
 end  
end
  

