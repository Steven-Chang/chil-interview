class CreateSubscriptionOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_options do |t|
    	t.string :description, null: false
    	t.decimal :price, precision: 10, scale: 2, default: 0.0

      t.timestamps

      t.index :description, unique: true
    end
  end
end
