class AddDeletedAtToContacts < ActiveRecord::Migration[8.0]
  def change
    add_column :contacts, :deleted_at, :string
  end
end
