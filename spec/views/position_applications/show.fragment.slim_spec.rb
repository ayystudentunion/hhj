require 'spec_helper'

describe 'position_applications/show.fragment.slim' do
  let(:application) {
    FactoryGirl.build(:kirjakerho_application, position: :position_both)
  }

  it 'should render for application for normal application' do
    test_partial
    expect(rendered).not_to match(/translation_missing/)
  end

  it 'should render with one char deputy' do
    application.deputy_of = '-'
    test_partial
    expect(rendered).not_to match(/translation_missing/)
  end

  it 'should have translation missing for unknown position' do
    application.position = 'foobar'
    test_partial
    expect(rendered).to match(/translation_missing/)
  end

  def test_partial
    assign(:position_application, application)
    assign(:university, Organization.find_by(key: 'sty'))
    render
  end
end
