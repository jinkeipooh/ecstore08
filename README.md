# README


## アプリケーション概要
	オンラインショッピングができるECサイトアプリケーションを作成しました。
	商品を出品及び購入することができます。
	購入の際は個数を選択してカートに入れ、レジに進みクレジット処理によって購入することができます。

## URL
	https://ecstore08.herokuapp.com/

## テスト用アカウント
	購入者用
	メールアドレス: kei@gmail.com
	パスワード: keikei08
	購入用カード情報
	番号：4242424242424242
	期限：Mon Apr 26 2030 00:00:00 GMT+0900 (JST)
	セキュリティコード：123
	出品者用
	メールアドレス名: master@gmail.com
	パスワード: master08

## 利用方法
	WebブラウザGoogle Chromeの最新版を利用してアクセスしてください。
	ただしデプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続してください。
	接続先およびログイン情報については、上記の通りです。
	同時に複数の方がログインしている場合に、ログインできない可能性があります。
	出品者アカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品
	購入者アカウントでログイン→トップページから商品を押下→個数を指定しカに入れるボタンを押下→カート詳細画面でレジに進むボタンを押下→購入画で入
	確認後、ログアウト処理をお願いします。


## 目指した課題解決
	ECサイトのカート機能を実装することで、欲しい商品をカートに入れ、まとめて決済できるようにしたこと

## 洗い出した要件

機能 | 目的 | 詳細 | ストーリー（ユースケース） | 見積もり（所要時間） 
-|-|-|-|-
DB設計|アプリ全体に必要なテーブルを選出|||5
ユーザー管理機能|deviseを用いたユーザー管理機能|トップページ上部にログイン、新規登録ボタンを表示。ログイン時はログアウトボタンを表示。|商品の購入、出品をしたいユーザーはログイン、もしくは新規登録をする必要がある。|4
商品出品機能|ECサイトに必要な商品を出品する機能|トップページ左の出品ボタンから出品ページへ|ユーザーは商品画像、名前、価格を入力することで出品可能。|4
商品一覧表示|商品一覧を表示する機能|トップページに自分以外のユーザーが出品した商品一覧を表示|トップページで商品一覧を閲覧|3
商品詳細表示|商品の詳細を表示する機能|トップページの各商品をクリックすることでページ遷移|出品したユーザーはこの画面で編集・削除。購入者はトップページから商品をクリックすることで、ページ遷移、数量を選択しカートに入れるボタンでカートに商品を追加|3
商品削除機能|出品した商品を削除する機能|商品詳細画面から削除を押下する|不要になった商品を詳細画面から削除ボタンを押下することで削除する。|3
カート機能|商品をカートに追加、削除する機能|複数商品を購入する際にカートに入れてから購入できるようにする|商品詳細画面からカートに入れるボタンを押下することでカートに商品を追加、画面左のカートボタンからカート画面に遷移。削除ボタンを押下することでカートから商品を削除することができる。|16
商品購入機能|カートに追加した商品を購入する機能|カート画面からレジに進むボタンを押下し遷移|カート画面からレジに進むボタンを押下し、クレジット情報を入力したのち購入するボタンを押下|6
クレジットカード事前登録機能|クレジットカードを事前に登録し、決済の際に利用できる機能|カート画面からレジに進むボタンを押下し遷移|マイページから事前登録。登録しない状態でレジに進むと登録の画面に自動遷移|4


## 実装した機能についての画像やGIFおよびその説明
### カート機能
[![Image from Gyazo](https://i.gyazo.com/2450a9117ae4b2862da00fa647b9d8a8.gif)](https://gyazo.com/2450a9117ae4b2862da00fa647b9d8a8)

## 実装予定の機能
<!-- 洗い出した要件の中から、今後実装予定の機能がある場合は、その機能を記述。 -->

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

- has_many :items
- has_one :cart
- has_many :cart_items
- has_many :orders
- has_one :card, dependent: :destroy


### items テーブル

| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| name          | string     | null: false       |
| text          | text       | null: false       |
| category_id   | integer    | null: false       |
| price         | integer    | null: false       |
| user          | references | foreign_key: true |

#### Association

- belongs_to :user
- has_many :carts, through: :cart_items
- has_many :cart_items


### carts テーブル

| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| user          | references | foreign_key: true |

#### Association

- belongs_to :user
- has_many :cart_items
- has_many :items, through: :cart_items


### cart_items

| Column        | Type       | Options                 |
| ------------  | ---------- | ----------------------- |
| item          | references | foreign_key: true       |
| cart          | references | foreign_key: true       |
| user          | references | foreign_key: true       |
| quantity      | integer    | default: 0, null: false |

#### Association

- belongs_to :user
- belongs_to :item
- belongs_to :cart


### orders テーブル

orders
| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| user           | references | foreign_key: true |
| cart           | references | foreign_key: true |
| quantity       | integer    | null: false       |
| total_price    | integer    | null: false       |

| Column         | Type       | Options           |
| -------------- | ---------- | ----------------- |
| user           | references | foreign_key: true |
| item           | references | foreign_key: true |
| address        | references | foreign_key: true |
| stock_quantity | integer    |                   |
| price          | integer    | null: false       |

#### Association

- belongs_to :user
- belongs_to :cart


### cards テーブル

| Column         | Type       | Options           |
| -------------  | ---------- | ----------------- |
| customer_token | string     | null: false       |
| user           | references | foreign_key: true |

#### Association

- belongs_to :user


<!-- ### order_details

| Column        | Type       | Options           |
| ------------  | ---------- | ----------------- |
| item          | references | foreign_key: true |
| order         | references | foreign_key: true |
| quantity      | integer    | null: false       |

#### Association

belongs_to :order
belongs_to :item


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

- belongs_to :user -->

<!-- ## ローカルでの動作方法 -->
<!-- git cloneしてから、ローカルで動作をさせるまでに必要なコマンドを記述。この時、アプリケーション開発に使用した環境を併記することを忘れないこと## （パッケージやRubyのバージョンなど）。 -->