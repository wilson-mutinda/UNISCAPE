class AddDeletedAtToApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :applications, :deleted_at, :datetime
  end
end
