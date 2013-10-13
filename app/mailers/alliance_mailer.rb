# coding: utf-8
class AllianceMailer < ActionMailer::Base
  default :from => '"Halloped" <admin@halloped.fi>'
  
  def confirmation_email(membership, university, url)
    @call_title = membership.position_application.call.title
    @alliance = membership.alliance
    @university = university
    @url = url
    mail(:to => membership.position_application.user.email, :subject => "Kutsu vaaliliittoon. Inbjudan till valförbund. Invite to an electoral alliance.")
  end

  class Job
    include SuckerPunch::Job

    def perform(membership_id, university_id, url)
      membership = ::AllianceMembership.find(membership_id)
      university = ::Organization.find(university_id)
      ::AllianceMailer.confirmation_email(membership, university, url).deliver
    end
  end
end
