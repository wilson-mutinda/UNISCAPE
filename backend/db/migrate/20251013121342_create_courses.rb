class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :course_duration
      t.string :course_fee
      t.text :course_desc
      t.text :course_more_info

      t.timestamps
    end
  end
end
