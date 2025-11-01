class ApplicationNotificationMailer < ApplicationMailer

  # email to the applicant
  def new_application_email(application)
    @application = application
    mail(
      to: @application.email,
      subject: "Thank you for your application, #{@application.first_name}!"
    )
  end

  # Internal notification to the admin team (info@uniscape.co.ke)
  def notify_admin(application)
    @application = application
    mail(
      to: "info@uniscape.co.ke",
      subject: "New Application Received: #{@application.first_name} #{@application.last_name}"
    )
  end
end
