require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe "商品新規登録" do
    context '商品出品できるとき' do
      it "image, name, text, category_id, price, user_idが存在すれば登録できる" do
       expect(@item).to be_valid
      end
      it "category_idが1以外なら登録できる" do
        @item.category_id = '2'
        expect(@item).to be_valid
      end
    end
    context '商品出品できないとき' do
      it "imageが空では登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "画像を入力してください"
      end
      it "nameが空だと登録できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end
      it "textが空では登録できない" do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品説明を入力してください"
      end
      it "category_idが1だと登録できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーを選択してください"
      end
      it "priceが空だと登録できない" do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格を入力してください"
      end
      it "priceが全角文字では登録できない" do
        @item.price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は300~9999999円の間で入力してください"
      end
      it "priceが300未満は登録できない" do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は300~9999999円の間で入力してください"
      end
      it "priceが9999999より大きい値は登録できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は300~9999999円の間で入力してください"
      end
      it "priceが半角英数字混合では登録できない" do
        @item.price = '100aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は300~9999999円の間で入力してください"
      end
      it "priceが半角英字のみでは登録できない" do
        @item.price = 'aaaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は300~9999999円の間で入力してください"
      end
      it "user_idが空だと登録できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Userを入力してください"
      end
    end
  end
end
