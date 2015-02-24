require 'spec_helper'

describe Organization do

  it 'can be converted to full tree hash with all recursive children' do
    FactoryGirl.create(:kirjasto)
    tree = Organization.root.tree_hash[:children]
    tree.count.should > 0
    str_dump = tree.to_s
    str_dump.should include('Kirjasto')
  end

end
