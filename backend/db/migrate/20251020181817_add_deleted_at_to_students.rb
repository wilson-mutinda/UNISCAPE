class AddDeletedAtToStudents < ActiveRecord::Migration[8.0]
  def change
    add_reference :students, :country, null: false, foreign_key: true
    add_column :students, :slug, :string
    add_column :students, :deleted_at, :datetime
  end
end
