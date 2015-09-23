require 'spec_helper'

describe CallsController do
  before :each do
    @call1 = FactoryGirl.create :lukurinki
    @call2 = FactoryGirl.create :call_for_student_council_board

    @call1_uni_key = @call1.organ.organization.root.key
    @call2_uni_key = @call2.organ.organization.root.key

    @call1_uni_key.should == 'sty'
    @call2_uni_key.should == 'helsinki'
  end

  it 'should have a working show page' do
    get :show, id: @call1.id, university: @call1_uni_key

    response.should be_success
  end

  it 'should not allow access to calls through the wrong university' do
    get :show, id: @call1.id, university: @call2_uni_key

    response.response_code.should == 404
  end
end
