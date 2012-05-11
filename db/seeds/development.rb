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

FactoryGirl.create(:tasa_arvotyoryhma)
FactoryGirl.create(:kirjakerho)
FactoryGirl.create(:akhaimenidien_kirjakerho)

if not Admin.where(email: 'halloped@localhost.fi').exists?
  Admin.create! email:'halloped@localhost.fi', password:'password', password_confirmation:'password'
end
