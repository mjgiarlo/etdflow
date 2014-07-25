Feature: Manage my contact information
As an author
I should be able to manage the contact information for my submissions 

  Scenario: Confirm my contact information
    Given I have not yet entered my author information
    When I go to the author submissions page
    Then I should be prompted to confirm my contact information
    When I click the "Confirm my contact information" link
    Then I should be on the new author page
    When I fill in my author information
    And I click the "Save" button
    Then I should be on the author submissions page
    And I should see my new contact information
    And There should be a link to "Start a new Submission"
    And I should see that I don't have any submissions yet
    And I should see a preview of the submission process
  
  Scenario: Edit my contact information
    Given My contact information already exists in etdlfow
    When I go to the author submissions page
    And I click the "update" link within "#contact-information"
    When I fill in my author information
    And I click the "Save" button
    Then I should be on the author submissions page
    And I should see my new contact information

