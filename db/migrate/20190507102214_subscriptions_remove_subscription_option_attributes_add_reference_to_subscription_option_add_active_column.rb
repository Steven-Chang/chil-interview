class SubscriptionsRemoveSubscriptionOptionAttributesAddReferenceToSubscriptionOptionAddActiveColumn < ActiveRecord::Migration[5.2]
  def change
  	remove_column :subscriptions, :description
  	remove_column :subscriptions, :price
  	add_reference :subscriptions, :subscription_option
  	add_column :subscriptions, :active, :boolean, default: true, null: false
  end
end
