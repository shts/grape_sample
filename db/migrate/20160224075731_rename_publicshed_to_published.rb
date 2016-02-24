class RenamePublicshedToPublished < ActiveRecord::Migration
  def change
    rename_column :entries, :publicshed, :published
  end
end
