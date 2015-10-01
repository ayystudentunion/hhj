# coding: utf-8
class AllianceMailer < ActionMailer::Base
  default :from => '"Halloped" <admin@halloped.fi>'

  def confirmation_email(membership, university, url)
    @call_title = membership.position_application.call.title
    @alliance = membership.alliance
    @university = university
    @url = url
    mail(:to => membership.position_application.user.email, :subject => "Kutsu vaaliliittoon. Inbjudan till valförbund. Invitation to an electoral alliance.")
  end

  def membership_confirmed(membership, university, url)
    @call_title = membership.position_application.call.title
    @alliance = membership.alliance
    @membership = membership
    @university = membership.position_application.call.university

    mail to: @alliance.creator.email, subject: "Jäsenyys vaaliliitossa on vahvistettu. Medlemskap i valförbund har bekräftats. Membership in electoral coalition has been confirmed."
  end

  class Job
    include SuckerPunch::Job

    def perform(membership_id, university_id: nil, url: nil, email: :confirmation_email)
      membership = ::AllianceMembership.find(membership_id)
      if university_id
        university = ::Organization.find(university_id)
      end
      ::AllianceMailer.send(email, membership, university, url).deliver_now
    end
  end
end
