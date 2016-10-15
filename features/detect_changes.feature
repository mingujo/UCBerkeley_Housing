Feature: Dectect changes made
  As an app
  I want to detect changes on the Google Doc
    
  Background: Info on the Google Doc

  Scenario: Detect edits
    Given the doc is being edited
    Then the state should be "editing"
    
  Scenario: Not being edited
    Given the doc is not being edited
    Then the state should not be "editing"