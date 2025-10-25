class AddApplicationSlugToApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :applications, :slug, :string
  end
end
