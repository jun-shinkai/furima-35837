class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_many_attached :images
  has_many :messages, dependent: :destroy
  has_many :item_tag_relations,dependent: :destroy
  has_many :tags, through: :item_tag_relations


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :scheduled_delivery
  belongs_to_active_hash :sales_status
  belongs_to_active_hash :category

 
end
