class ItemsTag

  include ActiveModel::Model
  attr_accessor :images,:tag_name,:name,:info,:category_id,:sales_status_id,:shipping_fee_status_id,:prefecture_id,:scheduled_delivery_id,:price,:user_id

  VALID_PRICEL_HALF = /\A[0-9]+\z/
  with_options presence: true do
    with_options numericality: { other_than: 0 } do
      validates :category_id
      validates :sales_status_id
      validates :shipping_fee_status_id
      validates :prefecture_id
      validates :scheduled_delivery_id
    end
    validates :name
    validates :info
    validates :images
    validates :user_id
    validates :tag_name

    validates :price, format: { with: VALID_PRICEL_HALF }, length: { minimum: 3, maxinum: 7 }, numericality: { only_integer: true,
                                                                                                               greater_than: 299, less_than: 10_000_000 }
  end
  def save
    item = Item.create(name: name,info: info, price: price,category_id: category_id,sales_status_id: sales_status_id, shipping_fee_status_id:shipping_fee_status_id,prefecture_id: prefecture_id,scheduled_delivery_id: scheduled_delivery_id,images: images,user_id:user_id)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

end