class AddEmailSentToApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :applications, :email_sent, :boolean
  end
end
