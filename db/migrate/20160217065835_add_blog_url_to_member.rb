class AddBlogUrlToMember < ActiveRecord::Migration
  def change
    add_column :members, :blog_url, :string
  end
end
