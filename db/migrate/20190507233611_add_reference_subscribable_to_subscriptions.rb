class AddReferenceSubscribableToSubscriptions < ActiveRecord::Migration[5.2]
  def change
  	add_reference :subscriptions, :subscribable, polymorphic: true, index: true, null: true
  end
end
