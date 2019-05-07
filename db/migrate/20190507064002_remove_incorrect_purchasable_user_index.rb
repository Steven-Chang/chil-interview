class RemoveIncorrectPurchasableUserIndex < ActiveRecord::Migration[5.2]
  def change
  	remove_index :orders, name: "index_orders_on_purchasable_and_user_id"
  end
end
