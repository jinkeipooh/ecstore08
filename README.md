# README


## アプリケーション概要
	このアプリケーションでできることを記述。

## URL
	https://ecstore08.herokuapp.com/

## テスト用アカウント
    購入者用
    メールアドレス: ######@gmail.com
    パスワード: ######
    購入用カード情報
    番号：4242424242424242
    期限：Mon Apr 26 2030 00:00:00 GMT+0900 (JST)
    セキュリティコード：123
    出品者用
    メールアドレス名: ######@gmail.com
    パスワード: ######

## 利用方法
	WebブラウザGoogle Chromeの最新版を利用してアクセスしてください。
  ただしデプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続してください。
  接続先およびログイン情報については、上記の通りです。
  同時に複数の方がログインしている場合に、ログインできない可能性があります。
  出品者アカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品
  購入者アカウントでログイン→トップページから商品を押下→個数を指定しカートに入れるボタンを押下→カート詳細画面でレジに進むボタンを押下→購入画面で購入
  確認後、ログアウト処理をお願いします。


## 目指した課題解決
	カート機能を実装することで、欲しい商品をまとめて決済できるようにしたこと

## 洗い出した要件
	スプレッドシートにまとめた要件定義を記述。 ######

## 実装した機能についての画像やGIFおよびその説明
	実装した機能について、それぞれどのような特徴があるのかを列挙する形で記述。画像はGyazoで、GIFはGyazoGIFで撮影すること。

## 実装予定の機能
	洗い出した要件の中から、今後実装予定の機能がある場合は、その機能を記述。

## データベース設計
### users テーブル

| Column               | Type   | Options     |
| -------------------- | ------ | ----------- |
| email                | string | null: false |
| encrypted_password   | string | null: false |
| nickname             | string | null: false |
| family_name          | string | null: false |
| first_name           | string | null: false |
| birthday             | date   | null: false |

#### Association

- has_one :address
- has_many :orders


### addresses テーブル
      
| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| post_code     | string     | null: false       |
| prefecture_id | integer    | null: false       |
| city          | string     | null: false       |
| house_num     | string     | null: false       |
| building      | string     |                   |
| phone_num     | string     | null: false       |
| user          | references | foreign_key: true |

#### Association

- belongs_to :user


### orders テーブル

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| user           | references | foreign_key: true |
| item           | references | foreign_key: true |
| address        | references | foreign_key: true |
| stock_quantity | integer    |                   |
| price          | integer    | null: false       |

orders
| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| user           | references | foreign_key: true |
| cart           | references | foreign_key: true |
| quantity       | integer    | null: false       |
| total_price    | integer    | null: false       |

#### Association

- belongs_to :user
- belongs_to :cart
- has_many :order_details
- has_many :item, through: :order_details


### order_details

| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| item          | references | foreign_key: true |
| order         | references | foreign_key: true |
| quantity      | integer    | null: false       |

#### Association

belongs_to :order
belongs_to :item


### items テーブル

| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| name          | string     | null: false       |
| text          | text       | null: false       |
| category_id   | integer    | null: false       |
| price         | integer    | null: false       |
| user          | references | foreign_key: true |

#### Association

has_many :order_derails
has_many :orders, through: :order_details
has_many :line_items
has_many :carts, through: :line_items


### carts テーブル （#idのみ保持）

| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| user          | references | foreign_key: true |

#### Association

has_many :cart_items
has_many :items, through: :line_items


### cart_items

| Column        | Type       | Options                 |
| ------------  | ---------- | ----------------------- |
| item          | references | foreign_key: true       |
| cart          | references | foreign_key: true       |
| quantity      | integer    | default: 0, null: false |

#### Association

belongs_to :item
belongs_to :cart


## ローカルでの動作方法
	git cloneしてから、ローカルで動作をさせるまでに必要なコマンドを記述。この時、アプリケーション開発に使用した環境を併記することを忘れないこと## （パッケージやRubyのバージョンなど）。