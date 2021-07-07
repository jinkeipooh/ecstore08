class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  has_one_attached :image
  belongs_to :user

  validates :category_id, numericality: { other_than: 1, message: "を選択してください"} 
  with_options presence: true do
    validates :image
    validates :name
    validates :text
    with_options numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は300~9999999円の間で入力してください" } do  #300~9999999かつ
      validates :price,format: { with: /\A[0-9]+\z/i, message: "は半角数字のみで入力してください"} #半角数値のみ登録可能
    end
  end
end