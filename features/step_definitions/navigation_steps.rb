# -*- encoding : utf-8 -*-

def visit_university(university_key, locale=I18n.default_locale)
  visit university_path(locale: locale, university: university_key)
end

When %r/^I press '([^']*)'$/ do |text|
  click_on text
end

When %r/^I follow the link '([^']*)'$/ do |link_title|
  click_link link_title
end

Given %r/^I am at front page of '([^']*)'$/ do |university_name|
   visit_university Organization.roots.where(name: university_name).first.key
end

Given %r/^I navigate to home page of organ '([^']*)'$/ do |organ_name|
  click_link 'Toimielimet'
  click_link organ_name
end

Given %r/^I navigate to home page of call '([^']*)'$/ do |call_name|
  click_link 'Avoimet haut'
  click_link call_name
end

Then %r/^show me the page$/ do
  save_and_open_page
end

And %r/^I change language to '([^']*)'$/ do |locale|
  visit '/' + current_path.split('/').reject(&:blank?).drop(1).unshift(locale).join('/')
end
