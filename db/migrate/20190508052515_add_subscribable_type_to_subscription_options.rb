class AddSubscribableTypeToSubscriptionOptions < ActiveRecord::Migration[5.2]
  def change
  	add_column :subscription_options, :subscribable_type, :string
  end
end
