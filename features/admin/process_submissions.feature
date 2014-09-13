Feature: Manage submissions
  As an eTD Flow admin
  I need to see a breakdown of all submissions
  So that I can process them

  Background:
    Given I am a partner admin

  Scenario: List existing submissions by type
    Given submissions exist for each type and status
    When I go to the admin dashboard page
    Then I should see the title for the default degree type
    And I should be able to navigate to all submissions by degree type

  Scenario: Delete an incomplete format review
    Given two incomplete format review exists
    And I go to the admin dashboard page
    When I click the "Format Review is Incomplete" link
    Then I should see the submissions listed
    When I click the "Select All" button
    Then I should see a button to delete selected
    When I click the "Delete selected" button
    Then I should be on the admin default type incomplete format review submissions page
    And I should no longer see the submissions

  Scenario: Approve a submitted format review
    Given a submitted format review exists
    And I go to the admin dashboard page
    And I click the "Format Review is Submitted" link
    Then I should see the submission listed
    When I click the title of the submitted format review
    And I click the "format_review_file_01.pdf" link
    Then I should see a link to view the PDF file
    And the file looks good
    And I fill in "Format Review Notes to Student" with "It looks good"
    And I click the "Approve Format Review" button
    Then I should be on the admin default type format review submitted page
    And I should no longer see the submission
    When I go to the admin dashboard page
    And I click the "Final Submission is Incomplete" link
    Then I should see the submission listed

  Scenario: Reject a submitted format review
    Given a submitted format review exists
    And I go to the admin dashboard page
    And I click the "Format Review is Submitted" link
    Then I should see the submission listed
    When I click the title of the submitted format review
    And I click the "format_review_file_01.pdf" link
    Then I should see a link to view the PDF file
    And the file looks bad
    And I fill in "Format Review Notes to Student" with "There are a few problems"
    And I click the "Reject & request revisions" button
    Then I should be on the admin default type format review submitted page
    And I should no longer see the submission
    When I go to the admin dashboard page
    And I click the "Format Review is Incomplete" link
    Then I should see the submission listed