class ChangeSubscriptionsActiveToNullTrue < ActiveRecord::Migration[5.2]
  def change
  	change_column :subscriptions, :active, :boolean, null: true
  end
end
