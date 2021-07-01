class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipality, :address, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :municipality
    validates :address
    validates :phone_number, format: { with: /\A\d{10}$|^\d{11}\z/ }
    validates :item_id
    validates :user_id
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)

    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address,
                   building: building, phone_number: phone_number, order_id: order.id)
  end
end

# pattern1 
# 現状のままにする
# メリット　書き換える必要がほとんどない
# デメリット　テーブル設計が若干いびつ

# patter2
# テーブルを増やす
# メリット　新規登録時の住所と、購入時の住所を明確に分けることができる
# デメリット　書き換えが多い　設計を間違えるとエラー多発？

# pattern3
# 購入時に住所を保存しない
# メリット　ほとんど追加の作業は不要
# デメリット　購入画面が簡素になる　多少依存関係に問題あり

