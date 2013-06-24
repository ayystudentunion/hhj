# coding: utf-8
class AllianceMailer < ActionMailer::Base
  default from: "admin@halloped.fi"
  
  def confirmation_email(application, university, url)
    @application = application
    @university = university
    @url = url
    mail(:to => application.user.email, :subject => "Sinut on lisätty vaaliliittoon. Samma på svenska. You have been added to an electoral alliance.")
  end
end
