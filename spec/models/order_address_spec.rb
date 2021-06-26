require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品購入ができるとき' do
      it '商品の情報が正常であれば登録できる' do
        expect(@order).to be_valid
      end
      it 'buildingが空でも登録できる' do
        @order.building = ''
        expect(@order).to be_valid
      end
    end

    context '商品購入がができないとき' do
      it 'postal_codeが空だと登録できない' do
        @order.postal_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include "郵便番号を入力してください"
      end
      it 'postal_codeは「3桁ハイフン4桁」の半角文字列以外だと登録できない' do
        @order.postal_code = '3333333'
        @order.valid?
        expect(@order.errors.full_messages).to include "郵便番号は不正な値です"
      end

      it 'prefecture_idが空では登録できない' do
        @order.prefecture_id = ''
        @order.valid?
        expect(@order.errors.full_messages).to include "都道府県を入力してください"
      end
      it 'prefecture_idが0だと登録できない' do
        @order.prefecture_id = 0
        @order.valid?
        expect(@order.errors.full_messages).to include "都道府県を選択してください"
      end

      it 'municipalityが空だと登録できない' do
        @order.municipality = ''
        @order.valid?
        expect(@order.errors.full_messages).to include "市区町村を入力してください"
      end
      it 'addressが空では登録できない' do
        @order.address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include "番地を入力してください"
      end
      it 'phone_numberが空だと登録できない' do
        @order.phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include "電話番号を入力してください"
      end
      it 'phone_numberが9桁以下だと登録できない' do
        @order.phone_number = '000000000'
        @order.valid?
        expect(@order.errors.full_messages).to include "電話番号は不正な値です"
      end
      it 'phone_numberが12桁以上だと登録できない' do
        @order.phone_number = '000000000000'
        @order.valid?
        expect(@order.errors.full_messages).to include "電話番号は不正な値です"
      end
      it 'phone_numberが英数混合だと登録できない' do
        @order.phone_number = 'aaaaa0000000'
        @order.valid?
        expect(@order.errors.full_messages).to include "電話番号は不正な値です"
      end
      it 'phone_numberが数字のみでないと登録できない' do
        @order.phone_number = '123-4567-0000'
        @order.valid?
        expect(@order.errors.full_messages).to include "電話番号は不正な値です"
      end
      it 'phone_numberが全角数字だと登録できない' do
        @order.phone_number = '０００００００００００'
        @order.valid?
        expect(@order.errors.full_messages).to include "電話番号は不正な値です"
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include "Userを入力してください"
      end
      it 'アイテムが紐付いていなければ投稿できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include "Itemを入力してください"
      end
      it 'tokenが空では投稿できない' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include "カード情報を入力してください"
      end
    end
  end
end
