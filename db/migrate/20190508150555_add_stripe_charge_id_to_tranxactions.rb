class AddStripeChargeIdToTranxactions < ActiveRecord::Migration[5.2]
  def change
    add_column :tranxactions, :stripe_charge_id, :string
    add_index :tranxactions, :stripe_charge_id, unique: true
  end
end