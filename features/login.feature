Feature: Login
  Background: There is a whitelisted email
    Given "ca@berkeley.edu" is whitelisted
  
  Scenario: Redirect to login if not signed in
    When I am on the home page
    Then I should be in the login page
    When I am on the ca page
    Then I should be in the login page
    
  Scenario: Signing in
    When I am on the login page
    And I sign in with "ca@berkeley.edu"
    Then I should be on my CA page
    When I go to the home page
    Then I should be on my CA page
    When I go to the CA page
    Then I should be on my CA page
  
  Scenario: Signing out
    Given I am signed in with "ca@berkeley.edu"
    When I click on sign out
    Then I should be on the login page
  
  Scenario: Admin
    When I am on the login page
    And I sign in as an Admin
    Then I should be on the CA page
    When I go to the home page
    Then I should be on the CA page
  
  Scenario: Whitelist email
    Given I am signed in as an Admin
    When I go to the add CA page
    And I fill in email with "foo@berkeley.edu"
    And I press submit
    Then I should be on the CA page
    And I should see "foo@berkeley.edu"
    
  Scenario: Un-Whitelist email
    Given I am signed in as an Admin
    And I go to the CA page for "ca@berkeley.edu"
    And I press delete
    Then I should see the confirmation prompt
    And I press yes
    Then I should be on the CA page 
    And I should not see "ca@berkeley.edu"
  
  Scenario: Not authorized
    Given I am signed in with "not@berkeley.edu"
    Then I should be on the not authorized page
    When I click sign out
    Then I should be on the login page