# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Call do

  it 'should report total number of selected' do
    c = FactoryGirl.create :call, title: 'Otsikko', member_amount: 3, deputy_amount: 2
    c.total_number_of_selected.should == 5
  end

  it 'should report about unhandled applications' do
    FactoryGirl.create :helsinki_uni_board_application
    c = TestSingletons.call_for_student_council_board
    c.has_unhandled_applications.should == true
  end

  it 'strips filename according to sanitizer' do
    c = FactoryGirl.create :call, title: '<SaneMe!?#'
    c.file_name.should include '_SaneMe___'
  end
end
