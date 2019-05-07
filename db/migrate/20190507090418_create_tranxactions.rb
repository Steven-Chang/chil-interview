class CreateTranxactions < ActiveRecord::Migration[5.2]
  def change
    create_table :tranxactions do |t|
    	t.references :order, null: false
    	t.decimal :amount, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
