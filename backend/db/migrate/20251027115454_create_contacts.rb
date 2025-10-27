class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.text :name
      t.string :email
      t.text :message
      t.string :slug

      t.timestamps
    end
  end
end
