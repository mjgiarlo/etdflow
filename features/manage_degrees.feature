Feature: Manage degrees
  As a partner admin
  I should be able to create and manage degrees for my school
  So that authors can choose their degree type when submitting a paper

  Background:
    Given I am a partner admin

  Scenario: View degrees
    Given some degrees exist
    When I go to the degrees page
    Then I should see a listing of all the degrees
