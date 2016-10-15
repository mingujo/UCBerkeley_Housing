require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)


When /^the app looks for an e-mail address$/ do 
    pending
end


Given /^the state is "([^\"]*)"$/ do |state|
    pending
end

Given /^the app is "not "?being edited/ do
    pending
end

And /^it has "(not )"?been (.+) minutes$/ do |x, min|
    if x
        pending
    else
        pending
    end
end

Then /^a notification should "(not )"?have been sent$/ do |x|
    if x
        pending
    else
        pending
    end
end

Then /^it should find the e-mail address "(.*)"$/ do |email|
    pending
end

Then /^the state should be "(.*)"&/ do |state|
    pending
end
