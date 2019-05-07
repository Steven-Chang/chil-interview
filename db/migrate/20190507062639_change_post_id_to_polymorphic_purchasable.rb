class ChangePostIdToPolymorphicPurchasable < ActiveRecord::Migration[5.2]
  def change
  	remove_index :orders, :post_id
  	remove_column :orders, :post_id
  	add_reference :orders, :purchasable, polymorphic: true
  	add_index :orders, %i[purchasable user_id]
  end
end
