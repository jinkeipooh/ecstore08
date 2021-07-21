class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  # attr_accessor :token

  # with_options presence: true do
  #   validates :token
  # end
  
end
