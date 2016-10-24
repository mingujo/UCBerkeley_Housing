Feature: detect a change and send an email
  
  A scheduling officer makes some change on the spreadsheet
  As a CA
  So that I can receive an email which contains info of the change, 
	and the link to spreadsheet
  
  Background: Existing spreadsheet and table
    Given the following is fetched from the spreadsheet of 9/1 (maybe json):
  	  | time  | ca	   | client     | phone 	     | APT | current tenant |
  	  | 08:00 | HENRI  | Jackson    | 510-123-1234 | 101 | Enrique		  |
  	  | 11:00 |        | Jackson    | 510-123-1234 | 101 | Enrique		  |
  	  | 12:00 | ELISSA |    		    |              |     |      		    |
  	  | 13:00 | JANE   |			      |			         |     |      		    |
  	And the following timeslots of a day 9/1 exists:
  	  | time  | ca	   | client     | phone 	     | APT | current tenant |
  	  | 08:00 | HENRI  |		        |	    	       |     |     		        |
  	  | 11:00 |        |		        |	    	       |     |			          |
  	  | 12:00 | ELISSA | Jackson    | 510-123-1234 | 101 | Enrique        |
  	  | 13:00 |        |			      |       	     |     |         	      |
  	And the link to this spreadsheet is ______
  
      

  Scenario: Henri gets the email
    Given the e-mail address of "Henri" should be "mingu08@berkeley.edu"
    And "Henri" gets a "notification" email
    
  Scenario: Elissa gets the email
    Given the e-mail address of "Jane" should be "absterr08@berkeley.edu"
    And "Jane" gets a "cancellation" email
    
  Scenario: Jane does not get any email
    Given the e-mail address of "Jane" should be "absterr08@berkeley.edu"
    And "Jane" does not get any email
    
    
    # test the email contents in mailer rspec !!!!!!!!!!!!!!!!!!!