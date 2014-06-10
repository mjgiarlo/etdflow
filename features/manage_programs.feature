Feature: Manage programs
  As a partner admin
  I should be able to create and manage programs for my school
  So that authors can choose their program when submitting a paper

  Background:
    Given I am a partner admin

  Scenario: View listings
    Given some programs exist
    When I go to the programs page
    Then I should see a listing of all the programs
