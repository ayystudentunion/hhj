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
ENV['file'] = Rails.root.join('public/universities/helsinki/aalto.yml').to_s
Rake::Task["db:import:university"].invoke

helsinki = Organization.university_by_key('helsinki')
hallitus = helsinki.organs.create!(name: "Hallitus", official: true)
hallitus_call = hallitus.calls.create!(title: "Opiskelijaedustajia hallitukseen!", member_amount: 2, deputy_amount: 1)
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
