require 'spec_helper'

describe Organ do
  it 'can be created' do
    Organ.new(name: 'Test organ').save
    Organ.all.first.name.should  == 'Test organ'
  end
end
