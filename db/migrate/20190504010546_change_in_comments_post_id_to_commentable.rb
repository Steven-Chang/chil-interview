class ChangeInCommentsPostIdToCommentable < ActiveRecord::Migration[5.2]
  def change
  	remove_column :comments, :post_id
  	add_reference :comments, :commentable, polymorphic: true, index: true
  end
end
