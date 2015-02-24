Given /^'Helsingin yliopisto' has enabled alliances$/ do
  university = Organization.where(name: "Helsingin yliopisto").first
  university.update_attributes!(alliances_enabled: true)
end
