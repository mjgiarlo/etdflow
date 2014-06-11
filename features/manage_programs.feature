Feature: Manage programs
  As a partner admin
  I should be able to create and manage programs for my school
  So that authors can choose their program when submitting a paper

  Background:
    Given I am a partner admin

  Scenario: View programs
    Given some programs exist
    When I go to the programs page
    Then I should see a listing of all the programs

  Scenario: Create a new program
    Given I am on the programs page
    When I click the "Add a New Program" link
    Then I should be on the new program page
    When I fill in "Description" with "Acoustics"
    And I check "Is active"
    And I press "Create Program"
    Then I should be on the programs page
    And I should see the new program
