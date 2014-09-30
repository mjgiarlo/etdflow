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
    When I click the title of the submission
    Then I should see the format review fields
    When I click the "format_review_file_01.pdf" link
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
    When I click the title of the submission
    Then I should see a link to view the PDF file
    And the file looks bad
    And I fill in "Format Review Notes to Student" with "There are problem with your file. Please re-upload."
    And I click the "[delete]" link within "#format-review-file-1"
    And I click the "Reject & request revisions" button
    Then I should be on the admin default type format review submitted page
    And I should no longer see the submission
    When I go to the admin dashboard page
    And I click the "Format Review is Incomplete" link
    Then I should see the submission listed

  Scenario: Approve a submitted final submission
    Given a submitted final submission exists
    And I go to the admin dashboard page
    And I click the "Final Submission is Submitted" link
    Then I should see the submission listed
    When I click the title of the submission
    Then I should not see the format review fields
    And I should see valid content in the final submissions fields
    And I should see a link to view the PDF file
    When I click the Format Review Information heading
    Then I should see that the Format Review Notes to Stundent field is readonly
    And I should see a button to edit the Format Review Information
    When I click the "Edit Format Review Information" link
    Then I should see the edit button update
    And I should now be able to edit the Format Review Notes to Student field
    And the file looks good
    And I fill in "Final Submission Notes to Student" with "It looks good"
    And I click the "Approve Final Submission" button
    Then I should be on the admin default type final submission submitted page
    And I should no longer see the submission
    When I go to the admin dashboard page
    And I click the "Final Submission is Approved" link
    Then I should see the submission listed

  Scenario: Reject a submitted final submission
    Given a submitted final submission exists
    And I go to the admin dashboard page
    And I click the "Final Submission is Submitted" link
    Then I should see the submission listed
    When I click the title of the submission
    Then I should see a link to view the PDF file
    And the file looks bad
    And I fill in "Final Submission Notes to Student" with "There are problem with your final file. Please revise."
    And I click the "[delete]" link within "#final-submission-file-1"
    And I click the "Reject & request revisions" button
    Then I should be on the admin default type final submission submitted page
    And I should no longer see the submission
    When I go to the admin dashboard page
    And I click the "Final Submission is Incomplete" link
    Then I should see the submission listed

  Scenario: Release marked submissions for publication
    Given one approved final submission exists for each access level
    When I go to the admin dashboard page
    And I click the "Final Submission is Approved" link
    Then I should see the submissions listed
    When I click the "Select All" button
    Then I should see a button to release for publication
    And I click the "Release selected for publication" button
    Then I should be on the admin dashboard page
    And I should see that there are zero approved final submissions
    When I click the "Released eTDs" link
    Then I should see the submissions listed
    And all the Released eTDs should be archived in Fedora
