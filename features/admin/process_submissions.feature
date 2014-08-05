Feature: Manage submissions
  As an eTD Flow admin
  I need to see a breakdown of all submissions
  So that I can process them

  Background:
    Given I am a partner admin
    And some submissions exist for each type

  Scenario: List existing submissions by type
    When I go to the admin dashboard page
    Then I should see all of the default degree type submissions
    And I should be able to navigate to all degree type submissions
