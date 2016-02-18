class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :body
      t.string :yearmonth
      t.string :week
      t.string :day
      t.integer :author_id
      t.string :publicshed
      t.string :image_url_list
      t.integer :comment_id

      t.timestamps null: false
    end
  end
end
