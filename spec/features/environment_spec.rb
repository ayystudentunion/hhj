require 'spec_helper'

describe 'environmet', type: :feature do
  it 'should show server environmet' do
    visit '/env'

    page.should have_content('Environment Variables')
  end
end
