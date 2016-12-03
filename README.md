# UCBerkeley_Housing
UC Berkeley Family Housing Scheduler &amp; Automatic Notification Web App

## Members
 - Min
 - Sora
 - Erick
 - Abby
 - Nathan

### Links
 - Heroku: https://ucberkeley-housing.herokuapp.com/ 
 - Pivotal: https://www.pivotaltracker.com/n/projects/1887919
 

### App Goal
 - Timely notification of staff of any changes made to their apartment showing schedule. Problem: Apartment showings are added and changed ad hoc, sometimes last-minute, and it is difficult for staff to track due to inconsistent communication between staff and the department scheduling these apartment showings.

### Requested Feature
 - Automated email notification of additions/changes to apartment showings to relevant still will remove human error from the communication process.


### App Description 
- The app reads from a Google spreadsheet and sends email notifications when a change has been made for a certain CA. From the app, schedule changes made will also be reflected in the Spreadsheet.   In order for our app to write and read from the spreadsheet, its access must be set to accessible to anyone with the link. 
    - A CA can edit their schedule and info from their details page
    - Can view everyone’s schedules from the Calendar page
    - Admin can add CAs from the CA Info page
    - All spreadsheets listed on Spreadsheets page
    - Admin can populate spreadsheets
        - Enter the number of the month and year in format: M or MM and YYYY
        - Input the link to a newly created Spreadsheet. Please do not make any changes to the spreadsheet; input the default newly created spreadsheet.
- Because the app pulls all its info from the spreadsheet, there is a specific format that the Spreadsheet must follow.  In order for the app to work:
    - Basic layout and column placement of spreadsheet cannot change 
    - Time slots must be in 30 minute increments, either at H:00 or H:30
    - Can change things like font, color
- Some edge cases
    - Removing a CA availability from the app will not remove it from the website
    - Both scheduling office and CA office may not modify CA column in the Google spreadsheet. Manually modifying the column might make the app to not send a notification email to a corresponding timeslot.







### Sample Automated Notification Email View
#### New Schedule
![Alt text](/sample_email_view_1.jpg?raw=true "New Schedule")

#### Schedule Cancellation
![Alt text](/sample_email_view_2.jpg?raw=true "Schedule Cancellation")

[![Code Climate](https://codeclimate.com/github/mingujo/UCBerkeley_Housing/badges/gpa.svg)](https://codeclimate.com/github/mingujo/UCBerkeley_Housing)

[![Test Coverage](https://codeclimate.com/github/mingujo/UCBerkeley_Housing/badges/coverage.svg)](https://codeclimate.com/github/mingujo/UCBerkeley_Housing/coverage)

[![Issue Count](https://codeclimate.com/github/mingujo/UCBerkeley_Housing/badges/issue_count.svg)](https://codeclimate.com/github/mingujo/UCBerkeley_Housing)

[![Build Status](https://travis-ci.org/mingujo/UCBerkeley_Housing.svg?branch=master)](https://travis-ci.org/mingujo/UCBerkeley_Housing)