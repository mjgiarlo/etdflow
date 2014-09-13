Feature: Manage submissions
As an author
I need to complete all the thesis/dissertation submission steps
So that I can eventually graduate

  Background:
    Given some programs exist
    And some degrees exist

  Scenario: Complete the submission process
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
    When I click the "Provide committee" link within "#submission-1"
    And I provide my committee
    And I click the "Save Committee" button
    Then I should be on the author submissions page
    And My committee progress indicator should be updated
    And I should now be on "step-3" "Upload Format Review files"
    When I click the "Upload Format Review files" link within "#submission-1"
    And I choose my Format Review files
    And I click the "Submit files for review" button
    Then The system should save my Format Review files
    And I should be on the author submissions page
    And I should see that my Format Review is in process
    When My Format Review is approved
    Then My Format Review approval progress indicator should be updated
    And I should now be on "step-5" "Upload Final Submission files"
    When I click the "Upload Final Submission files" link within "#submission-1"
    And I fill in the Final Submission fields
    And I upload my Final Submission files
    And I click the "Submit final files for review" button
    Then The system should save my Final Submission files
    And I should be on the author submissions page
    And I should see that my Final Submission is in process

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

  Scenario: Update my committee
    Given I have started a submission and provided my committee
    When I go to the author submissions page
    And I click the "update" link within "#submission-1 .step-2"
    When I enter my new committee information
    And I click the "Update Committee" button
    Then I should be on the author submissions page
    And my committee should be updated
