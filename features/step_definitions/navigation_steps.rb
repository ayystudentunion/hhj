# -*- encoding : utf-8 -*-

def visit_university(university_key, locale = I18n.default_locale)
  visit university_path(locale: locale, university: university_key)
end

When /^I press '([^']*)'$/ do |text|
  click_on text
end

When /^I press '([^']*)' within dialog$/ do |text|
  within '#modal-wrap' do
    click_on text
  end
end

When /^I close the dialog$/ do
  find('a.close-modal').click
end

When /^I follow the link '([^']*)'$/ do |link_title|
  click_link link_title
end

Given /^I am at front page of '([^']*)'$/ do |university_name|
  visit_university Organization.roots.where(name: university_name).first.key
end

Given /^I navigate to home page of organ '([^']*)'$/ do |organ_name|
  click_link 'Toimielimet'
  click_link organ_name
end

Given /^I navigate to home page of call '([^']*)'$/ do |call_name|
  within '.navi-links' do
    click_link 'Avoimet haut'
  end
  click_link call_name
end

And /^I change language to '([^']*)'$/ do |locale|
  lang_selector = find ".language-sel a[hreflang=#{locale}]"
  lang_selector.click
end
