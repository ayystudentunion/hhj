require 'rails_helper'

describe Organization do

  it 'can be converted to full tree hash with all recursive children' do
    FactoryGirl.create(:kirjasto)
    tree = Organization.root.tree_hash[:children]
    expect(tree.count).to be > 0
    str_dump = tree.to_s
    expect(str_dump).to include('Kirjasto')
  end

end
