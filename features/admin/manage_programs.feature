Feature: Manage programs
  As a partner admin
  I should be able to create and manage programs for my school
  So that authors can choose their program when submitting a paper

  Background:
    Given I am a partner admin

  Scenario: View programs
    Given some programs exist
    When I go to the admin programs page
    Then I should see a listing of all the programs

  Scenario: Create a new program
    Given I am on the admin programs page
    When I click the "New Program" link
    Then I should be on the new admin program page
    When I fill in "Name" with "Acoustics"
    And I check "Is active"
    And I press "Create Program"
    Then I should be on the admin programs page
    And I should see the program Acoustics

  Scenario: Edit an existing program
    Given some programs exist
    And I am on the admin programs page
    When I choose a program to edit
    And I fill in "Name" with "MY NEW NAME"
    And I press "Update Program"
    Then I should be on the admin programs page
    And I should see the program MY NEW NAME
