class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
    	t.integer :buyer_id, null: false
    	t.integer :seller_id, null: false
    	t.integer :post_id, null: false

      t.timestamps

      t.index :buyer_id
      t.index :seller_id
      t.index :post_id
      t.index [:buyer_id, :seller_id, :post_id], unique: true
    end
  end
end
