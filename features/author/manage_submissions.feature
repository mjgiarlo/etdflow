Feature: Manage submissions
As an author
I need to initiate the thesis/dissertation submission process
So that I can eventually graduate

  Background:
    Given some programs exist
    And some degrees exist

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
  
  Scenario: Add my program information
    Given I have confirmed my contact information
    When I go to the author submissions page
    And I click the "Start a new Submission" link
    Then I should be on the new submission program information page 
    When I fill in my program information
    And I click the "Save Program Information" button
    Then I should be on the author submissions page
    And I should see my new program information
    And My program information progress indicator should be updated
    And I should now be on "step-2" "Provide committee"

  Scenario: Edit my contact information
    Given My contact information already exists in etdlfow
    When I go to the author submissions page
    And I click the "update" link within "#contact-information"
    When I fill in my author information
    And I click the "Save" button
    Then I should be on the author submissions page
    And I should see my new contact information

  Scenario: Delete my submission
    Given I have started a submission
    When I go to the author submissions page
    And I click the "delete" link within "#submission-1"
    Then I should be on the author submissions page
    And I should see that I don't have any submissions yet

  Scenario: Update my program information
    Given I have started a submission
    When I go to the author submissions page
    And I click the "update" link within "#submission-1"
    When I fill in my program information
    And I click the "Update Program Information" button
    Then I should be on the author submissions page
    And I should see my new program information

  Scenario: Provide my committee
    Given I am ready to provide my committee
    When I go to the author submissions page
    And I click the "Provide committee" link within "#submission-1"
    When I provide my committee
    And I click the "Save Committee" button
    Then I should be on the author submissions page
    And My committee progress indicator should be updated
    And I should now be on "step-3" "Upload Format Review files"
