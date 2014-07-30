Feature: Manage submissions
  As an eTD Flow admin
  I need to see a breakdown of all submissions
  So that I can process them

  Background:
    Given I am a partner admin
    And some dissertation submissions exist
    And some master thesis submissions exist

  Scenario: List existing submissions by type
    When I go to the admin home page
    Then I should see all of the dissertation submissions
    When I go to the admin master thesis submissions page
    Then I should see all of the master thesis submissions
