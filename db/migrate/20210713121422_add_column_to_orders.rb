class AddColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :quantity, :integer, null: false
    add_column :orders, :total_price, :integer, null: false
  end
end
