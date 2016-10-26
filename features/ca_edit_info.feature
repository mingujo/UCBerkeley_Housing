Feature: Edit CA info
  
	Background: there is a CA
		Given I am a CA
		And the following CAs exist:
		| name                   | email    | phone number |
		| A                      | a@a.com  | 111          |
		| B                      | b@b.com  | 222          |
  
	Scenario: Get to Add CA page
		Given I am on the "CA page"
		And I click "Add CA"
		Then I should be on the "Add CA page"

	Scenario: Get to Edit CA page
		Given I am on the "CA page"
		And I click "edit" for the CA "A"
		Then I should be on the "edit page" for "A"
		
	Scenario: Add CA
		Given I am on the "Add CA page"
		And I fill in "name" with "C"
		And I fill in "email" with "c@c.com"
		And I fill in "phone number" with "333"
		And I press submit
		Then I should be on the "CA page"
		And I should see "C"
		
	
	Scenario: Edit a CA
		#should have editable text boxes already filled with current info
		Given I am on the "edit page" for "A"
		And I fill in "name" with "AA"
		And I press "save"
		Then I should be on the "CA page"
		And I should see "AA"
		And I should not see "A"
		
	Scenario: Delete a CA
		Given I am on the "edit page" for "A"
		And I press "delete CA"
		#And a pop up appears asking if i am sure
		#And I press "yes"
		Then I should be on the "CA page"
		And I should not see "A"