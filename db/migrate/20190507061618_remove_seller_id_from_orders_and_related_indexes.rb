class RemoveSellerIdFromOrdersAndRelatedIndexes < ActiveRecord::Migration[5.2]
  def change
  	remove_index :orders, :seller_id
  	remove_index :orders, [:buyer_id, :seller_id, :post_id]
  	remove_column :orders, :seller_id
  end
end
