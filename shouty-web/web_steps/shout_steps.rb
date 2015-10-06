require 'shouty'
require 'shouty_app'

Before do
  @sean = Capybara::Session.new(:selenium, ShoutyApp)
  @lucy = Capybara::Session.new(:selenium, ShoutyApp)
  @sean.visit('/?name=Sean')
  @lucy.visit('/?name=Lucy')
end

Given(/^Lucy is (\d+)ft away from Sean$/) do |distance|
  pending
end

When(/^Sean shouts "(.*?)"$/) do |message|
  pending
end

Then(/^Lucy should not hear Sean's shout$/) do
  pending
end

Then(/^Lucy should hear Sean's shout$/) do
  pending
end

Then(/^Sean should not hear himself$/) do
  pending
end
