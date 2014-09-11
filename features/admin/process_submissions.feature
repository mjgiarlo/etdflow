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
