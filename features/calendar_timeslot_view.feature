Feature: Check schedules on a calendar view and timeslot view
	To allow CAs to view details of their appointments
	As a CA
	I should be able to open a timeslot showing the details

	Background:
		Given I am logged in
		And I am on the "calendar" page
	
	Scenario: View calendar page
		Then I see "November" on the top of the page

	Scenario: CA can check his/her name on certain date
		Given "Julia" put her availabilty on "11/5" at "08:00"
		And "Olga" put her availabilty on "11/5" at "09:00"
		Then "Julia" can see her name on "11/5" with "08:00" on a calendar
		And "Olga" put her availabilty on "11/5" with "09:00" on a calendar
		
	Scenario: Redirects the timeslots view if CA clicks any date
		Given "Julia" put her availabilty on "11/10" at "08:00"
		And I click "11/10" on a calendar
		Then I am on the "timeslot" page
		And I can see "11/10" on the page
		And I can see "Julia" at the slot of "08:00"