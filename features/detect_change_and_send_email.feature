Feature: detect a change and send an email
  
  A scheduling officer makes some change on the spreadsheet
  As a CA
  So that I can receive an email which contains info of the change, 
	and the link to spreadsheet
  
  Background: Existing spreadsheet and table
    Given the following is fetched from a spreadsheet of one day:
  	  | time  | ca	   | client     | phone 	     | APT | current tenant |
  	  | 08:00 | HENRI  | Jackson    | 510-123-1234 | 101 | Enrique		  |
  	  | 08:30 |        | Jackson    | 510-123-1234 | 101 | Enrique		  |
  	  | 09:00 | ELISSA |    		    |              |     |      		    |
  	  | 11:31 | JANE   |			      |			         |     |      		    |
  	And the following timeslots of that day exists:
  	  | time  | ca	   | client     | phone 	     | APT | current tenant |
  	  | 08:00 | HENRI  |		        |	    	       |     |     		        |
  	  | 08:30 |        |		        |	    	       |     |			          |
  	  | 09:00 | ELISSA | Jackson    | 510-123-1234 | 101 | Enrique        |
  	  | 09:30 |        |			      |       	     |     |         	      |

  Scenario: Henri gets the email
    Given the e-mail address of "Henri" be "henri@berkeley.edu"
    And "Henri" gets a "notification" email
    
  Scenario: Elissa gets the email
    Given the e-mail address of "Jane" be "jane@berkeley.edu"
    And "Jane" gets a "cancellation" email
    
  Scenario: Jane does not get any email
    Given the e-mail address of "Jane" be "jane@berkeley.edu"
    And "Jane" does not get any email
    
    
    # test the email contents in mailer rspec !!!!!!!!!!!!!!!!!!!