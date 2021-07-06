# README

## users テーブル

| Column               | Type   | Options     |
| -------------------- | ------ | ----------- |
| email                | string | null: false |
| encrypted_password   | string | null: false |
| nickname             | string | null: false |
| family_name          | string | null: false |
| first_name           | string | null: false |
| birthday             | date   | null: false |

### Association

- has_one :address
- has_many :orders


##addresses テーブル
      
| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| post_code     | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| house_num     | string     | null: false       |
| building      | string     |                   |
| phone_num     | string     | null: false       |
| user          | references | foreign_key: true |

### Association

- belongs_to :user


##orders テーブル

| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| user     | references | foreign_key: true |
| item     | references | foreign_key: true |
| address  | references | foreign_key: true |
| quantity | integer    |  |
| price    | integer    | null: false       |

### Association

- belongs_to :user
- has_many :order_details
- has_many :item, through: :order_details


##order_details

| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| item          | references | foreign_key: true |
| order         | references | foreign_key: true |
| quantity      | integer    |  |

### Association

belongs_to :order
belongs_to :item


##items テーブル

| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| name          | string     | null: false       |
| text          | text       | null: false       |
| category_id   | integer    | null: false       |
| price         | integer    | null: false       |
| user          | references | foreign_key: true |

### Association

has_many :order_derails
has_many :orders, through: :order_details
has_many :line_items
has_many :carts, through: :line_items


##carts テーブル （#idのみ保持）

| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |

### Association

has_many :line_items
has_many :items, through: :line_items


##line_items

| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| item          | references | foreign_key: true |
| cart          | references | foreign_key: true |
| quantity      | integer    |  |

### Association

belongs_to :item
belongs_to :cart