# -*- encoding : utf-8 -*-

When %r/^I press '([^']*)'$/ do |text|
  click_on text
end

When %r/^I follow the link '([^']*)'$/ do |link_title|
  click_link link_title
end

Given %r/^I am viewing the front page$/ do
  visit('/')
end

Given %r/^I am in home page or organ '([^']*)'$/ do |organ_name|
  visit('/')
  step "I follow the link 'Toimielimet'"
  step "I follow the link '#{organ_name}'"
end

Then %r/^show me the page$/ do
  save_and_open_page
end

And %r/^I change language to '([^']*)'$/ do |locale|
  visit '/' + current_path.split('/').reject(&:blank?).drop(1).unshift(locale).join('/')
end
