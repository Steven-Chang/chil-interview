class TranxactionsRenameOrderIdToPurchaseId < ActiveRecord::Migration[5.2]
  def change
  	rename_column :tranxactions, :order_id, :purchase_id
  end
end
