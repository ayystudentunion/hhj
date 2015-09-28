require 'spec_helper'

describe 'admin', type: :feature do
  it 'should load' do
    admin = Admin.create! email: 'admin@example.com', password: 'foobar'

    visit '/admin'

    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'foobar'

    click_button 'Log in'

    page.should have_content('Site Administration')
    page.should have_content('Signed in successfully.')
  end
end
