class AddDeletedAtToCountries < ActiveRecord::Migration[8.0]
  def change
    add_column :countries, :deleted_at, :datetime
  end
end
