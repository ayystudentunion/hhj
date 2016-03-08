require 'spec_helper'

describe User do
  it 'can edit call results' do
    user = FactoryGirl.create :aaro
    user.can_edit_call_results?
  end
end
