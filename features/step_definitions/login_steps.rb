Given(/^"([^"]*)" is whitelisted$/) do |email|
  Ca.create(email: email)
end

Given (/^"([^"]*)" is admin$/) do |email|
  Admin.create(email: email)
end

When(/^I sign in with "([^"]*)"$/) do |email|
  auth_hash = {info: {email: email}, uid: email.hash}
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = auth_hash
  step 'I go to the auth page'
end

Given(/^I am signed in with "([^"]*)"$/) do |email|
  step 'I go to the login page'
  step "I sign in with \"#{email}\""
end

Then(/^I should be in the not authorized page$/) do
  step 'I should be on the login page'
  step 'I should see "not authorized"'
end

Then(/^I should be in my CA page$/) do
  current_path = URI.parse(current_url).path
  current_path.should == ca_path(1)
end

When(/^I click on sign out$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I sign in as an Admin$/) do
  step 'I sign in with "housingnotificationsystem@gmail.com"'
end

Given(/^I am signed in as an Admin$/) do
  step 'I go to the login page'
  step 'I sign in as an Admin'
end

When(/^I click sign out$/) do
  pending # Write code here that turns the phrase above into concrete actions
end