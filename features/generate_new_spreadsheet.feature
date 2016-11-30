Feature: Generate a new spreadsheet for next month
  
	As an admin
	I create a new Google spreadsheet for next month schedules
	So that CAs can add their availabilities for next month
	
	Background: admin is logged in
		Given I am signed in as an Admin
		And current month is "November"
		Given I am on the "generate new spreadsheet" page
		And I fill in "Month" with "December"
		And I fill in "Year" with "2016"
		And I press "Generate"
		Given I am on the "Add Availability" page for the CA "Someone"
		And I select "2016", "December", "1", "08 AM", and "00" for "start" time
		And I select "2016", "December", "1", "08 AM", and "30" for "end" time
		And I select "Does not repeat" for repeats
		
	Scenario: create a spreadsheet 
		Then I am on the "new spreadsheet link" page
		And I can see new link to the spreadsheet
		
	Scenario: CA put new availability on new spreadsheet
		Then on the new spreadsheet for december I can see the "new" schedule

	Scenario: CA puts new availability on time where there is no spreadsheet
		Given I am on the "Add Availability" page for the CA "Someone"
		And I select "2017", "January", "1", "08 AM", and "00" for "start" time
		And I select "2017", "January", "1", "08 AM", and "30" for "end" time
		And I select "Does not repeat" for repeats
		Then I see the message "You're not able to add availability for 2017 January"

	Scenario: CA deletes new availability on new spreadsheet
		Given I am on the detail page of "Someone"
		And I select "2016", "December", "1", "08 AM", and "00" schedule
		And I press edit link
		And I select "2016", "December", "1", "09 AM", and "00" for "end" time
		And I press "update"
		Then on the new spreadsheet for december I cannot see the new schedule


	Scenario: CA edits new availability on new spreadsheet
		Given I am on the detail page of "Someone"
		And I select "2016", "December", "1", "08 AM", and "00" schedule
		And I press edit link
		And I select "2016", "December", "1", "09 AM", and "00" for "end" time
		And I press "update"
		Then on the new spreadsheet for december I can see the "updated" schedule


