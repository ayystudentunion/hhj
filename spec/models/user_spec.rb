require 'spec_helper'

describe User do

  it 'can edit call results' do
    user = Factory.create :aaro
    user.can_edit_call_results?
  end

end
