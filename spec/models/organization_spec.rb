require 'spec_helper'

describe Organization do
  it 'can be converted to full tree hash with all recursive children' do
    FactoryGirl.create(:kirjasto)
    tree = Organization.root.tree_hash[:children]
    tree.count.should > 0
    str_dump = tree.to_s
    str_dump.should include('Kirjasto')
  end

  it 'provides an error on duplicate key' do
    h = FactoryGirl.create(:helsinki_uni)

    o = Organization.new key: h.key

    o.should have(1).errors_on(:key)
  end

  it 'provides an error with blank key' do
    o = Organization.new key: ''

    o.should have(1).errors_on(:key)
  end
end
