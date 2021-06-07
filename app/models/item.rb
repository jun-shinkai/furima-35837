class Item < ApplicationRecord

    belongs_to :user
    #has_one :order
    has_one_attached :image
    
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to_active_hash :prefecture
    belongs_to_active_hash :shipping_fee_status
    belongs_to_active_hash :scheduled_delivery
    belongs_to_active_hash :sales_status
    belongs_to_active_hash :sales_status
    
    VALID_PRICEL_HALF =                 /\A[0-9]+\z/
  with_options presence: true do
    with_options  numericality: { other_than: 0 } do
      validates :category_id            
      validates :sales_status_id          
      validates :shipping_fee_status_id   
      validates :prefecture_id            
      validates :scheduled_delivery_id    
    end
    validates :name                  
    validates :info                     
   validates :content, unless: :was_attached?       
    validates :price ,format: {with: VALID_PRICEL_HALF},length: {minimum: 3, maxinum: 7},numericality: { only_integer: true,
      greater_than: 300, less_than: 10000000
      }
                            
  end
   

  def was_attached?
    self.image.attached?
  end
end
