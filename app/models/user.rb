class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_one :cart
  has_many :cart_items
  has_many :orders
  has_one :card, dependent: :destroy
  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :password, format: {
      with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i,
      message: "パスワードは英字と数字の両方を含めて6文字以上で設定してください"
      }
    with_options format: {
      with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
      message: "は全角で入力して下さい"
    } do
      validates :family_name
      validates :first_name
    end
  end
end