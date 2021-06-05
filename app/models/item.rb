class Item < ApplicationRecord

    belongs_to :user
    #has_one :order

  with_options presence: true do
    validates :category_id            
    validates :sales_status_id          
    validates :shipping_fee_status_id   
    validates :prefecture_id            
    validates :scheduled_delivery_id    
    validates :name                  
    validates :info                     
    validates :price                                    
  end

end
