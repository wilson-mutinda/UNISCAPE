class RemoveImageUrlFromBlogPost < ActiveRecord::Migration[8.0]
  def change
    remove_column :blog_posts, :image_url, :string
  end
end
