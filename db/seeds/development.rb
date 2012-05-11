# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl_rails'

ENV['file'] = Rails.root.join('public/universities/helsinki/helsinki.yml').to_s
Rake::Task["db:import:university"].invoke
ENV['file'] = Rails.root.join('public/universities/aalto/aalto.yml').to_s
Rake::Task["db:import:university"].execute

helsinki = Organization.university_by_key('helsinki')
hallitus = helsinki.organs.create!(name: "Hallitus", official: true)
professori = helsinki.users.create!(first_name: "Toimi", last_name: "Sumelius", email: "toimi@helsinki.fi")
hallitus.members.create!(user: professori, group: :group_professors)
university_staff = helsinki.users.create!(first_name: "Eila", last_name: "Kolehmainen", email: "eila@helsinki.fi")
hallitus.members.create!(user: university_staff, group: :group_staff)
member_user = helsinki.users.create!(first_name: "Elina", last_name: "Kummala", email: "elina.kummala@helsinki.fi")
member = hallitus.members.create!(user: member_user, group: :group_hallopeds, position: :position_member, term_start: Time.utc(2012,2,3), term_end: Time.utc(2014,2,3))
deputy_user = helsinki.users.create!(first_name: "David", last_name: "Kummala", email: "david.kummala@helsinki.fi")
deputy = hallitus.members.create!(user: deputy_user, group: :group_hallopeds, position: :position_deputy, member: member, term_start: Time.utc(2012,2,3), term_end: Time.utc(2014,2,3))
hallitus_call = hallitus.calls.create!(title: "Opiskelijaedustajia hallitukseen!", member_amount: 2, deputy_amount: 1, workflow: :workflow_proposal_available)
student_pekka = helsinki.users.create!(first_name: "Pekka", last_name: "Lemminkäinen", email: "pekka.lemminkainen@helsinki.fi")
student_paula = helsinki.users.create!(first_name: "Paula", last_name: "Rimminki", email: "paula.rimminki@helsinki.fi")
hallitus_call.position_applications.create(user: student_pekka, position: :position_both, personal_statement: "Olisin hyvä halloped!")
hallitus_call.position_applications.create(user: student_paula, position: :position_deputy, deputy_of: "Pekka Lemminkäinen", personal_statement: "Haluaisin vain varajäseneksi siis.")


kansanterveystiede = helsinki.descendants.where(name: "Kansanterveystiede").first
tasaarvotyoryhma = kansanterveystiede.organs.create!(name: "Tasa-arvotyöryhmä", official: true)
tasaarvotyoryhma.calls.create!(title: "Tasa-arvon takaajia tarvitaan!", member_amount: 3, deputy_amount: 2)



if not Admin.where(email: 'halloped@localhost.fi').exists?
  Admin.create! email:'halloped@localhost.fi', password:'password', password_confirmation:'password'
end
