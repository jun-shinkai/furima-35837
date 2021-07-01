class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string                 :postal_code ,        null: false
      t.integer                :prefecture_id,      null: false
      t.string                 :municipality,       null: false
      t.string                 :address,            null: false
      t.string                 :building          
      t.string                 :phone_number,       null: false
      t.references             :order        ,foreign_key: true
      t.references             :user        ,foreign_key: true
      t.timestamps
    end
  end
end
