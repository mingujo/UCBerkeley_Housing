Given(/^"([^"]*)" is whitelisted$/) do |email|
  Ca.create(email: email)
end

When(/^I sign in with "([^"]*)"$/) do |email|
  auth_hash = {info: {email: email}, user_id: email.hash}
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

When(/^I click on sign out$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I sign in as an Admin$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I am signed in as an Admin$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I fill in email with "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I press submit$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I press delete$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see the confirmation prompt$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I press yes$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I click sign out$/) do
  pending # Write code here that turns the phrase above into concrete actions
end