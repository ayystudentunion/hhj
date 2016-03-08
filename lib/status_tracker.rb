module StatusTracker
  def self.global_success
    AllianceMembership.all.count do |membership|
      membership.position_application.admissible?
    end
  end
end
