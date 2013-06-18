Given /^'Spartan Teknillinen Yliopisto' has enabled alliances$/ do
  university = Organization.where(name: "Spartan Teknillinen Yliopisto").first
  university.update_attributes!(alliances_enabled: true)
end
