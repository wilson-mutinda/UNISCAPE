class RemoveDeletedAtFromCourses < ActiveRecord::Migration[8.0]
  def change
    remove_column :courses, :deleted_at, :string
  end
end
