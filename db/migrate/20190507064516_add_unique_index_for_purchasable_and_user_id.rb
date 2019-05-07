class AddUniqueIndexForPurchasableAndUserId < ActiveRecord::Migration[5.2]
  def change
  	add_index :orders, [:purchasable_type, :purchasable_id, :user_id], unique: true, name: "index_unique_purchase"
  end
end
