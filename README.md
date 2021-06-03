
# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last-name          | string | null: false |
| first-name         | string | null: false |
| last-name-kana     | string | null: false |
| first-name-kana    | string | null: false |

### Association

- has_many :items
- has_many :orders




## items テーブル

| Column                   | Type     | Options     |
| ------------------------ | -------- | ----------- |
| item-category            | string   | null: false |
| brand                    | string   | null: false |
| item-name                | string   | null: false |
| item-info                | string   | null: false |
| item-image               | string   | null: false |
| item-sales-status        | string   | null: false |
| item-shipping-fee-status | string   | null: false |
| item-prefecture          | string   | null: false |
| item-scheduled-delivery  | string   | null: false |
| item-price               | string   | null: false |
| user_id                  |references| foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column    | Type       | Options           |
| --------- | ---------- | ------------------|
| user_id   | references | foreign_key: true |
| items_id  | references | foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address

## address テーブル

| Column          | Type     | Options     |
| --------------- | -------- | ----------- |
| Postal code     | string   | null: false |
| prefecture      | string   | null: false |
| Municipality    | string   | null: false |
| address         | string   | null: false |
| building        | string   | null: false |
| phone number    | string   | null: false |
| order_id        |references| foreign_key: true |

### Association

- belongs_to :order