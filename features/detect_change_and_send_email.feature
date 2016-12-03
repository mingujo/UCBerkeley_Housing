Feature: detect a change and send an email
  
  A scheduling officer makes some change on the spreadsheet
  As a CA
  So that I can receive an email which contains info of the change, 
	and the link to spreadsheet
  
  Background: Existing spreadsheet and table
    Given the e-mail address of "Henri" be "TEST_GUY_EMAIL_ADDR"
    And the e-mail address of "Jane" be "TEST_GUY_EMAIL_ADDR"
    And the e-mail address of "Elissa" be "TEST_GUY_EMAIL_ADDR"
    And the following is fetched from a spreadsheet of one day:
      | 9/12/2016 Monday||||||
      | ALL APPOINTMENTS MUST BE SCHEDULED AT LEAST 2 DAYS IN ADVANCE||||||
      | time  | ca     | client     | phone        | APT | current tenant |
      | 08:00 | Henri  | Jackson    | 510-123-1234 | 101 | Enrique      |
      | 08:30 |        | Jackson    | 510-123-1234 | 101 | Enrique      |
      | 09:00 | Elissa |            |              |     |              |
      | 09:30 | Jane   |            |              |     |              |
  	And the following timeslots of that day exists:
      | 9/12/2016 Monday||||||
      | ALL APPOINTMENTS MUST BE SCHEDULED AT LEAST 2 DAYS IN ADVANCE||||||
      | time  | ca     | client     | phone        | APT | current tenant |
      | 08:00 | Henri  |            |              |     |              |
      | 08:30 |        |		        |              |     |              |
      | 09:00 | Elissa | Jackson    | 510-123-1234 | 101 | Enrique      |
      | 09:30 | Jane   |            |              |     |              |

  Scenario: Henri gets the email
    Then "Henri" gets a "new_schedule_notification" email for date: "9/12/2016", time: "08:00"
    
  Scenario: Elissa gets the email
    Then "Elissa" gets a "cancellation" email for date: "9/12/2016", time: "09:00"
    
  Scenario: Jane does not get any email
    Then "Jane" does not get any email for date: "9/12/2016", time: "09:30"
