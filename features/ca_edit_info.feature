Feature: Edit CA info
  
	Background: there is a CA
		Given the following CAs exist:
		| name                   | email             | phone number |
		| Someone                | someone@test.com  | 111          |
		| Sometwo                | sometwo@test.com  | 222          |
  
# 	Scenario: Get to Add CA page
# 		Given I am on the "CA page"
# 		And I click "Add CA"
# 		Then I should be on the "Add CA page"

# 	Scenario: Get to Edit CA page
# 		Given I am on the "CA page"
# 		And I click "edit" for the CA "Someone"
# 		Then I should be on the "edit page" for "Someone"
		
# 	Scenario: Add CA
# 		Given I am on the "Add CA page"
# 		And I fill in "name" with "Somethree"
# 		And I fill in "email" with "somethree@test.com"
# 		And I fill in "phone number" with "333"
# 		And I press submit
# 		Then I should be on the "CA page"
# 		And I should see "Somethree"
		
	
# 	Scenario: Edit a CA
# 		#should have editable text boxes already filled with current info
# 		Given I am on the "edit page" for "Someone"
# 		And I fill in "name" with "Noone"
# 		And I press "save"
# 		Then I should be on the "CA page"
# 		And I should see "Noone"
# 		And I should not see "Someone"
		
	Scenario: Delete CA
	  Given I am on the "edit" page for "Someone"
	  And I press "Delete"
	  Then I should be on the "CA page"
	  And I should not see "Someone"
	  But I should see "Sometwo"