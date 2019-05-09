class AddAmountToPurchases < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :amount, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
