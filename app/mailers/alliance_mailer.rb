# coding: utf-8
class AllianceMailer < ActionMailer::Base
  default from: "admin@halloped.fi"
  
  def confirmation_email(membership, university, url)
    @call_title = membership.position_application.call.title
    @alliance_name = membership.alliance.name
    @university = university
    @url = url
    mail(:to => membership.position_application.user.email, :subject => "Sinut on lisätty vaaliliittoon. Samma på svenska. You have been added to an electoral alliance.")
  end
end
