require 'shouty'

Before do
  shoutbox = Shoutbox.new
  @sean = shoutbox['Sean']
  @lucy = shoutbox['Lucy']
end

Given(/^Lucy is (\d+)ft away from Sean$/) do |distance|
  @sean.location = 0
  @lucy.location = distance.to_i
end

When(/^Sean shouts "(.*?)"$/) do |message|
  @sean.shout(message)
  @seans_message = message
end

Then(/^Lucy should not hear Sean's shout$/) do
  if @lucy.last_heard_message == @seans_message
    raise "Lucy heard Sean's message (but we didn't expect him to)"
  end
end

Then(/^Lucy should hear Sean's shout$/) do
  if @lucy.last_heard_message != @seans_message
    raise "Lucy did not hear the message (but we expected her to)"
  end
end

Then(/^Sean should not hear himself$/) do
  if @sean.last_heard_message == @seans_message
    raise "Sean heard himself - that's bad"
  end
end
