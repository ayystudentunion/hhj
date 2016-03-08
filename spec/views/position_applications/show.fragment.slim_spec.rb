require 'spec_helper'

describe 'position_applications/show.fragment.slim' do
  let(:application) do
    FactoryGirl.build(:kirjakerho_application, position: :position_both)
  end

  it 'should render for application for normal application' do
    test_partial
    rendered.should_not match(/translation missing/)
  end

  it 'should render with one char deputy' do
    application.deputy_of = '-'
    test_partial
    rendered.should_not match(/translation missing/)
  end

  it 'should have translation missing for unknown position' do
    application.position = 'foobar'
    test_partial
    rendered.should match(/translation missing/)
  end

  def test_partial
    assign(:position_application, application)
    assign(:call, application.call)
    assign(:university, Organization.find_by(key: 'sty'))
    render
  end
end
