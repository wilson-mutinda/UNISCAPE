class CreateBlogPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :excerpt
      t.text :content
      t.string :slug
      t.boolean :published
      t.string :image_url

      t.timestamps
    end
  end
end
