Feature: send notification email
    After client names are written down
    I want to send an email notification to the relevant CA
    
    Background: Info on the Google Doc
      Given the CA email

    Scenario: Send notification email when client names are written down
        Given a change in "CLIENT NAME" row has been made on the Google Doc,
        And I find "CA" and "TIME" in the same row in which changes have been made
        And I see "CA"'s "email address" on the separate spreadsheet
        Then I should send the email notification
    
