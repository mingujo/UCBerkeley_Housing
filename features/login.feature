Feature: Login
  Background: There is a whitelisted email
    Given "housingnotificationsystem@gmail.com" is admin
    Given "ca@berkeley.edu" is whitelisted
  
  Scenario: Redirect to login if not signed in
    When I am on the home page
    Then I should be on the login page
    When I go to the cas page
    Then I should be on the login page
    
  Scenario: Signing in
    When I am on the login page
    And I sign in with "ca@berkeley.edu"
    Then I should be in my CA page
    When I go to the home page
    Then I should be in my CA page
    When I go to the CA page
    Then I should be in my CA page
  
  Scenario: Signing out
    Given I am signed in with "ca@berkeley.edu"
    When I follow "Sign out"
    Then I should be on the login page
  
  Scenario: Admin
    When I am on the login page
    And I sign in as an Admin
    Then I should be on the CA page
  
  Scenario: Whitelist email
    Given I am signed in as an Admin
    When I go to the add CA page
    And I fill in "Name" with "Foo Bar"
    And I fill in "Email" with "foo@berkeley.edu"
    And I fill in "Phone Number" with "foo-foo-fooo"
    And I press "Add"
    Then I should be on the CA page
    And I should see "foo@berkeley.edu"
    
  Scenario: Un-Whitelist email
    Given I am signed in as an Admin
    And I go to the CA page for email "ca@berkeley.edu"
    And I follow "Edit CA Info"
    And I press "Delete"
    Then I should be on the CA page 
    And I should not see "ca@berkeley.edu"
  
  Scenario: Not authorized
    Given I am signed in with "not@berkeley.edu"
    Then I should be in the not authorized page