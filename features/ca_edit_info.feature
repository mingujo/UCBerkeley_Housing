# Feature: Edit CA info
  
# 	Background: there is a CA
# 		Given the following CAs exist:
# 		| name                   | email             | phone number |
# 		| Someone                | someone@test.com  | 111          |
# 		| Sometwo                | sometwo@test.com  | 222          |
  
# 	Scenario: Get to Add CA page
# 		Given I am on the "CA page"
# 		And I click "ADD CA"
# 		Then I should be on the "Add CA page"
# # was click changed to press
# 	Scenario: Get to CA Details page
# 		Given I am on the "CA page"
# 		And I go to "Details" for the CA "Someone"
# 		Then I should be on the CA page for "Someone"
		
# 	Scenario: Get to CA Edit page
# 	    Given I am on the "Details" page for the CA "Someone"
# 		And I click "Edit CA Info"
# 		Then I should be on the "edit" page for "Someone"
		
# 	Scenario: Add CA
# 		Given I am on the "Add CA page"
# 		And I fill in "Name" with "Somethree"
# 		And I fill in "Email" with "somethree@test.com"
# 		And I fill in "Phone Number" with "333"
# 		And I press "Add"
# 		Then I should be on the "CA page"
# 		And I should see "Somethree"
		
	
# 	Scenario: Edit a CA
# 		#should have editable text boxes already filled with current info
# 		Given I am on the "edit" page for "Someone"
# 		And I fill in "Name" with "Noone"
# 		And I press "Save"
# 		Then I should be on the CA page for "Noone"
# 		And I should see "Noone"
# 		And I should not see "Someone"
		
# 	Scenario: Delete CA
# 	  Given I am on the "edit" page for "Someone"
# 	  And I press "Delete"
# 	  Then I should be on the "CA page"
# 	  And I should not see "Someone"
# 	  But I should see "Sometwo"