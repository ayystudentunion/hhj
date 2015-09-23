require 'spec_helper'

describe 'admin', type: :feature do
  it 'should load' do
    visit '/admins/sign_in'

    page.should have_content('Sign in')
  end
end
