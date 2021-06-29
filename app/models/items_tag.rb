class ItemsTag

  include ActiveModel::Model
  attr_accessor :images,:tag_name,:name,:info,:category_id,:sales_status_id,:shipping_fee_status_id,:prefecture_id,:scheduled_delivery_id,:price,:user_id
  attr_accessor :item_name, :tag_name

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
    validates :images, if: :require_validation?

    validates :user_id
    validates :tag_name

    validates :price, format: { with: VALID_PRICEL_HALF }, length: { minimum: 3, maxinum: 7 }, numericality: { only_integer: true,
                                                                                                               greater_than: 299, less_than: 10_000_000 }
  end

     # itemがすでに保存されているものか、新規のものかで、PUTとPATCHを分ける
     delegate :persisted?, to: :@item
     
      # initializeでFormオブジェクトの値を初期化し、更新の際はdefault_attributesを呼び出す設定
  def initialize(attributes = nil, item: Item.new)
      @item = item
      attributes ||= default_attributes
      super(attributes)
  end

  def save
    if invalid?
      return
    end

          
    ActiveRecord::Base.transaction do
      tags = split_tag_names.map { |tag_name| Tag.find_or_create_by!(tag_name: tag_name) }
      # tag = Tag.where(tag_name: tag_name).first_or_initialize
      if images.blank?
        @item.update!(name: name,info: info, price: price,category_id: category_id,sales_status_id: sales_status_id, shipping_fee_status_id:shipping_fee_status_id,prefecture_id: prefecture_id,scheduled_delivery_id: scheduled_delivery_id,user_id:user_id)
      else
        @item.update!(name: name,info: info, price: price,category_id: category_id,sales_status_id: sales_status_id, shipping_fee_status_id:shipping_fee_status_id,prefecture_id: prefecture_id,scheduled_delivery_id: scheduled_delivery_id,images: images,user_id:user_id)
      end
      ItemTagRelation.find_or_create_by!(item_id: @item.id, tag_id: tags.last.id)
    end

    rescue ActiveRecord::RecordInvalid
      false
  end
    #  formを飛ばす場所を（#createか#updateか）を判別して、切り替えている
    def to_model
      @item
    end

    private

    
    def default_attributes
      {
        name: @item.name,info:@item.info,price:@item.price,category_id:@item.category_id,sales_status_id:@item.category_id,shipping_fee_status_id:@item.shipping_fee_status_id,prefecture_id:@item.prefecture_id,scheduled_delivery_id:@item.scheduled_delivery_id,user_id:@item.user_id,
        tag_name: @item.tags.pluck(:tag_name).join(',')
      }
    end

    def split_tag_names
      tag_name.split(',')
    end

    def require_validation?
      return false if @item.id.present? 
      true
    end
  end

