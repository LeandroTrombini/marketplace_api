class AddTotalToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :total, :decimal, default: 0.0
  end
end
