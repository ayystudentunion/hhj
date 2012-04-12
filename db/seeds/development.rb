# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl_rails'

def create_organizations(organizations, parent=nil)
  organizations.each do |org|
    create_organizations(
      org.fetch(:children, []),
      FactoryGirl.create(:organization, org.except(:children).merge(parent: parent))
    )
  end
end

create_organizations([
  {
    name: 'Spartan Teknillinen Yliopisto',
    key: 'sty',
    _id:  '4f6b1edf91bc2b33d3010000',
    children: [ {
      name: 'Luonnontieteellinen tiedekunta',
      _id:   '4f6b1edf91bc2b33d3010100',
      children: [
      {
        name: 'Kemian laitos',
        _id:   '4f6b1edf91bc2b33d3010101'
      }, {
        name: 'Fysiikan laitos',
        _id:   '4f6b1edf91bc2b33d3010102',
        children: [
        {
          name: 'Teoreettisen fysiikan yksikkö',
          _id:   '4f6b1edf91bc2b33d3010103'
        } ]
      } ]
    }, {
      name: 'Humanististen tieteiden tiedekunta',
      _id:   '4f6b1edf91bc2b33d3010300',
      children: [
      {
        name: 'Filosofinen laitos',
        _id:   '4f6b1edf91bc2b33d3010301'
      }, {
        name: 'Naistutkimuksen laitos',
        _id:   '4f6b1edf91bc2b33d3010302'
      } ]
    }, {
      name: 'Kirjasto',
      _id:   '4f6b1edf91bc2b33d3010200'
    } ]
  }, {
    name: 'Akhaimenidien Yliopisto',
    key: 'ay',
    _id:  '5e5c1edf91bc2b3300000000',
    children: [ {
      name: 'Mystiikan tiedekunta',
      _id:   '5e5c1edf91bc2b3301000000',
      children: [
      {
        name: 'Salatieteen laitos',
        _id:   '5e5c1edf91bc2b3301010000'
      } ]
    }]
  }]
)

def createOrgans(organs)
   organs.each{ |organ| FactoryGirl.create(:organ, organ) }
end

createOrgans( [ {
  name:  'Tasa-arvotyöryhmä',
  _id:   '4f6b1edf91bc2b3301010101',
  organization: Organization.find('4f6b1edf91bc2b33d3010101')
}, {
  name:  'Kirjakerho',
  _id:   '4f6b1edf91bc2b3302010101',
  organization: Organization.find('4f6b1edf91bc2b33d3010200')
} ] )

FactoryGirl.create(:lukurinki)
