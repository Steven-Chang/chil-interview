class RemoveDefaultFromActiveFromSubscriptions < ActiveRecord::Migration[5.2]
  def change
  	change_column :subscriptions, :active, :boolean, default: nil
  end
end
