class RemoveCommentIdFromEntry < ActiveRecord::Migration
  def change
    remove_column :entries, :comment_id, :string
  end
end
