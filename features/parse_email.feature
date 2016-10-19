Feature: Parse email from doc
  
  Background: 
    Given a page with e-mail address "absterr08@berkeley.edu"
    

  Scenario: Parse the e-mail address
    When the app looks for an e-mail address
    Then it should find the e-mail address "absterr08@berkeley.edu"