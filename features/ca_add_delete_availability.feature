# #And "Someone" is logged in
# Feature: Add and Delete CA Availability

# 	Background: there is a CA
# 		Given the following CAs exist:
# 		| name                   | email             | phone number |
# 		| Someone                | someone@test.com  | 111          |


# 		And I sign in with "someone@test.com"
# 		And "Someone" has the following availability: 
# 		| Day                    | Date              | Time                     |
# 		| Wednesday              | 11/2              | 1:00pm - 2:00pm          |
# 		| Wednesday              | 11/9              | 1:00pm - 2:00pm          |
# 		| Wednesday              | 11/16             | 1:00pm - 2:00pm          |
# 		| Wednesday              | 11/23             | 1:00pm - 2:00pm          |		

# 		And the current month is "November 2016"


#     Scenario: Get to Add Availibility page for CA
#     	Given I am on the "Details" page for the CA "Someone"
#     	And I click "Add Availibility"
#     	Then I should be on the "Add Availibility" page for the CA "Someone"
  


#   #NOTE: may change wording for "availibility for" depending on how availibility slots will be represented in our app and how we end up doing the view page

#     Scenario: Add CA Availability for whole month
#     	Given I am on the "Add Availability" page for the CA "Someone"
#     	And I select "Tuesday" from "Day"
#     	And I select "12:00pm" from "From"
#     	And I select "1:00pm" from "To"
#     	And I press "Save"
#     	Then I should be on the "Details" page for "Someone"
#     	And I should see availability for "Tuesday 11/1 12:00pm - 1:00pm"
#     	And I should see availability for "Tuesday 11/8 12:00pm - 1:00pm"
#     	And I should see availability for "Tuesday 11/15 12:00pm - 1:00pm"
#     	And I should see availability for "Tuesday 11/22 12:00pm - 1:00pm"
#     	And I should see availability for "Tuesday 11/29 12:00pm - 1:00pm"




#     Scenario: Add CA Availability for one day
#     	Given I am on the "Add Availability" page for the CA "Someone"
#     	And I select "Tuesday" from "Day"
#     	And I select "12:00pm" from "From"
#     	And I select "1:00pm" from "To"
#     	And I select "One Time Only"
#     	And I fill in "Date" with "1"
#     	And I press "Save"
#     	Then I should be on the "Details" page for "Someone"
#     	And I should see availability for "Tuesday 11/1 12:00pm - 1:00pm"
#     	And I should not see availability for "Tuesday 11/8 12:00pm - 1:00pm"
#     	And I should not see availability for "Tuesday 11/15 12:00pm - 1:00pm"
#     	And I should not see availability for "Tuesday 11/22 12:00pm - 1:00pm"
#     	And I should not see availability for "Tuesday 11/29 12:00pm - 1:00pm"  



#     Scenario: Delete CA Availability
#         Given I am on the "Add Availability" page for the CA "Someone"
#         And I press "Delete" for the Availibility Slot "Wednesday 11/2 1:00pm - 2:00pm"
#         Then I should not see availability for "Wednesday 11/2 1:00pm - 2:00pm"
#     	And I should see availability for "Wednesday 11/9 1:00pm - 2:00pm"
#     	And I should see availability for "Wednesday 11/16 1:00pm - 2:00pm"
#     	And I should see availability for "Wednesday 11/23 1:00pm - 2:00pm"










