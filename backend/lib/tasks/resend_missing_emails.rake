namespace :applications do
  desc "send emails for applications that haven't received one yet"
  task send_missing_emails: :environment do
    unsent_apps = Application.where(email_sent: [false, nil])

    if unsent_apps.any?
      puts "Found #{unsent_apps.count} unsent aplications."
      unsent_apps.find_each do |app|
        begin
          ApplicationNotificationMailer.new_application_email(app).deliver_now
          app.update(email_sent: true)
          puts "Sent email to #{app.email}"
        rescue => e
          puts "Failed to send email to #{app.email}: #{e.message}"
        end
        
      end
    else
      puts "All applications have already been emailed!"
    end
  end
end