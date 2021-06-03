
# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false,unique: true |
| encrypted_password | string | null: false |
| last-name          | string | null: false |
| first-name         | string | null: false |
| last-name-kana     | string | null: false |
| first-name-kana    | string | null: false |
| user_birth_date    |　date | null: false |

### Association

- has_many :items
- has_many :orders




## items テーブル

| Column                   | Type     | Options     |
| ------------------------ | -------- | ----------- |
| item-category  _id          | integer  | null: false |
| brand                       | string   | null: false |
| item-name                   | string   | null: false |
| item-info                   | text     | null: false |
| item-sales-status_id        | integer  | null: false |
| item-shipping-fee-status_id | integer  | null: false |
| item-prefecture_id          | integer  | null: false |
| item-scheduled-delivery_id  | integer  | null: false |
| item-price                  | integer  | null: false |
| user                        |references| foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column    | Type       | Options           |
| --------- | ---------- | ------------------|
| user      | references | foreign_key: true |
| items     | references | foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address

## address テーブル

| Column          | Type     | Options     |
| --------------- | -------- | ----------- |
| Postal code     | string   | null: false |
| prefecture_id      | integer  | null: false |
| Municipality    | string   | null: false |
| address         | string   | null: false |
| building        | string   |
| phone number    | string   | null: false |
| order           |references| foreign_key: true |

### Association

- belongs_to :order