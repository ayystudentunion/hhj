# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl_rails'

def createOrganization(org)
   children = org.fetch(:children, []).map{ |child| createOrganization child}
   Factory(:organization, org.reject{|key, value| key == :children}.merge(children: children))
end

createOrganization( {
  name: 'Spartan Teknillinen Yliopisto',
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
} )

def createOrgans(organs)
   organs.each{ |organ| Factory(:organ, organ) }
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

Factory(:lukurinki)
