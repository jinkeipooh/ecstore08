require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '購入情報と送付先の登録' do
    before do
      user = FactoryBot.create(:user)
      cart = FactoryBot.create(:cart)
      @order = FactoryBot.build(:order, user_id: user.id, cart_id: cart.id)
      # sleep 0.1       ###テストへの負荷大きいため速度を遅くする （read_time以内に処理が終わらなかった? => beforeアクションはit~endの処理ごと毎回呼ばれるので、毎回DBへの保存処理を行っているため処理が重くなる）
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空だと登録できないこと' do
        @order.token = ''
        @order.valid?
        expect(@order.errors.full_messages).to include "クレジットカード情報を入力してください"
      end
    end
  end
end
