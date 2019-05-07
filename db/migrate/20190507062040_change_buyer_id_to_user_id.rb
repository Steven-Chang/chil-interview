class ChangeBuyerIdToUserId < ActiveRecord::Migration[5.2]
  def change
  	remove_index :orders, :buyer_id
  	rename_column :orders, :buyer_id, :user_id
  	add_index :orders, :user_id
  end
end
