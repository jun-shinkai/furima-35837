require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品ができるとき' do
      it '商品の情報が正常であれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品がができないとき' do
      it 'imageが空だと登録できない' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "商品画像を入力してください"
      end
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end
      it 'infoが空では登録できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の説明を入力してください"
      end
      it 'category_idは、が存在しなければ登録できない。' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーは数値で入力してください"
      end

      it 'sales_status_id が空では登録できない' do
        @item.sales_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の状態は数値で入力してください"
      end
      it 'shipping_fee_status_idが空だと登録できない' do
        @item.shipping_fee_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料の負担は数値で入力してください"
      end
      it ' prefecture_idが空だと登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "発送元の地域は数値で入力してください"
      end
      it 'scheduled_delivery_id ' do
        @item.scheduled_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数は数値で入力してください"
      end
      it 'price が空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格を入力してください"
      end
      it 'price が300以下だと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include '販売価格は299より大きい値にしてください'
      end
      it 'price が9,999,999以上だと登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は10000000より小さい値にしてください"
      end
      it 'price が半角数字以外だと登録できない' do
        @item.price = 'fwrfw'
        @item.valid?
        expect(@item.errors.full_messages).to include  "販売価格は数値で入力してください"
      end
      it 'category_id が0だと登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーは0以外の値にしてください"
      end
      it 'sales_status_id が0だと登録できない' do
        @item.sales_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include '商品の状態は0以外の値にしてください'
      end
      it 'shipping_fee_status_id が0だと登録できない' do
        @item.shipping_fee_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include '配送料の負担は0以外の値にしてください'
      end
      it 'prefecture_id  が0だと登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include '発送元の地域は0以外の値にしてください'
      end
      it 'scheduled_delivery_id が0だと登録できない' do
        @item.scheduled_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数は0以外の値にしてください"
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
