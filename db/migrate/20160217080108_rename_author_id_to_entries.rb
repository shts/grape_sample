class RenameAuthorIdToEntries < ActiveRecord::Migration
  def change
    rename_column :entries, :author_id, :member_id
  end
end
