# coding: utf-8
class ApplicationMailer < ActionMailer::Base
  default from: "admin@halloped.fi"
  
  def sent_email(application)
    @application = application
    mail(:to => application.user.email, :subject => "Hakemuksesi on vastaanotettu. Vi har mottagit din ansökan. Your application has been received.")
  end

  def reminder_to_send_application(partner_application, university, email)
    @partner_application = partner_application
    @call = partner_application.call
    @university = university
    mail(:to => email, :subject => "Muista hakea #{@call.title}-hakuun! Remember to apply for #{@call.title}! Kom ihåg att lämna in ansökan till #{@call.title}!")
  end

end
