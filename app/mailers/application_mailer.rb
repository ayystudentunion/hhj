# coding: utf-8
class ApplicationMailer < ActionMailer::Base
  default from: "admin@halloped.fi"
  
  def sent_email(application)
    @application = application
    mail(:to => application.user.email, :subject => "Hakemuksesi on vastaanotettu. Vi har mottagit din ansökan. Your application has been received.")
  end
end
