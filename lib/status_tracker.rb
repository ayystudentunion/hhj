module StatusTracker
  def self.global_success
    AllianceMembership.all.select do |membership|
      membership.position_application.admissible?
    end.size
  end
end
