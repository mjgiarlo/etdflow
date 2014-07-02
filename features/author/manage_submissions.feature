Feature: Manage submissions
As an author
I need to initiate the thesis/dissertation submission process
So that I can eventually graduate

Scenario: Visiting the site for the first time
  Given I have not yet entered my author information
  When I go to the author submissions page
  Then I should be prompted to confirm my contact information
  When I click the "Confirm my contact information" link
  Then I should be on the new author page
  When I fill in my author information
  And I click the "Save" button
  Then I should be on the submissions index page
  And I should see that I don't have any submissions yet
