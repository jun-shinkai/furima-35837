class OrderAddress
   include ActiveModel::Model
   attr_accessor :postal_code ,:prefecture_id, :municipality, :address,  :building,   :phone_number, :user_id, :item_id


   with_options presence: true do
      validates :postal_code, format:{with: /\A\d{3}[-]\d{4}\z/}
      validates :prefecture_id  ,numericality: {other_than: 0, message: "can't be blank"}
      validates :municipality
      validates :address
      validates :phone_number,format:{with: /\A\d{10}$|^\d{11}\z/}
      validates :item_id
      validates :user_id
   end
   
    def save
      # 寄付情報を保存し、変数donationに代入する
      order = Order.create(item_id: item_id, user_id: user_id)
      # 住所を保存する
      # donation_idには、変数donationのidと指定する
      Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building: building, phone_number: phone_number, order_id: order.id)
    end
  end