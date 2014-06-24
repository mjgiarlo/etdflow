Feature: Manage submissions
As an author
I need to initiate the thesis/dissertation submission process
So that I can eventually graduate

Scenario: Submit author information
  Given I am on the author dashboard page
  When I click the "Start a new submission" link
  Then I should be on the new format review page
  When I fill in the author information
  And I press "Create Paper"
  Then I should be on the author dashboard page