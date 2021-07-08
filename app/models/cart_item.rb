class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart
  belongs_to :user
end
