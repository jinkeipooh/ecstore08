require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "ユーザー新規登録" do

    context '新規登録できるとき' do
      it "email,password,password_confirmation,nickname,family_name,first_name,birthdayが存在すれば登録できる" do
       expect(@user).to be_valid
      end
      it "passwordとpassword_confirmationが6文字以上であれば登録できる" do
       @user.password = '1a1a1a'
       @user.password_confirmation = '1a1a1a'
       expect(@user).to be_valid
      end
      it "family_nameが全角なら登録できる" do
       @user.family_name = '全角名前'
       expect(@user).to be_valid
      end
      it "first_nameが全角なら登録できる" do
       @user.first_name = '全角名字'
       expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = '5a5a5'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it "family_nameが空では登録できない" do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字を入力してください"
      end
      it "family_nameが半角では登録できない" do
        @user.family_name = 'hankaku'
        @user.valid?
        expect(@user.errors.full_messages).to include "苗字は全角で入力して下さい"
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前を入力してください"
      end
      it "first_nameが半角では登録できない" do
        @user.first_name = 'hankaku'
        @user.valid?
        expect(@user.errors.full_messages).to include "名前は全角で入力して下さい"
      end
      it "birthdayが空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "誕生日を入力してください"
      end
    end
  end
end
