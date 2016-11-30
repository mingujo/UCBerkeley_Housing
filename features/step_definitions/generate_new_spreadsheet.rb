And /^current month is "(.*)"$/ do |month|
	#time = Time.new
	#month = time.strftime("%B")
	#expect(page).to have_content month
end
# Given /^I am on the  page
And /^I put "(.*)" on Month section$/ do |month|
	pending
end
And /^I put "(.*)" on Year section$/ do |year|
	pending
end

And /^I select "(.*)", "(.*)", "(.*)", "(.*)", and "(.*)" for "(.*)" time$/ do |year, month, date, hour, min, start|
	pending
end
And /^I select "(.*)" for repeats$/ do |repeat|
	pending
end

And /^I can see new link to the spreadsheet$/ do
	pending
end

Then /^on the new spreadsheet for december I can see the new schedule$/ do
	pending
end

Then /^I see the message "(.*)"$/ do |message|
	pending
end

And /^I select "(.*)", "(.*)", "(.*)", "(.*)", and "(.*)" schedule$/ do |year, month, date, hour, min|
	pending
end
And /^I press edit link$/ do
	pending
end
Then /^on the new spreadsheet for december I can see the "(.*)" schedule$/ do |new_or_updated|
	pending
end

Then /^on the new spreadsheet for december I cannot see the new schedule$/ do
	pending
end
