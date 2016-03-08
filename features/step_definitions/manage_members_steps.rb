Given /^a student exists$/ do
  FactoryGirl.create :student_emma
end

When /^I press the edit icon within organ members$/ do
  within '.organ-members.hallopeds' do
    find('.edit-icon').click
  end
end

When /^I fill in email field with "([^"]*)"$/ do |arg1|
  fill_in 'member[email]', with: arg1
end

When /^I press the plus$/ do
  within '.add-member' do
    find('a.btn.add-row').click
  end
end

And /^I press the cross$/ do
  within '.edit-members' do
    find('a.submit.btn.remove-member').click
  end
end
