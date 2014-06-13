Feature: Manage degrees
  As a partner admin
  I should be able to view and edit authors
  So that my school has up-to-date author information

  Background:
    Given I am a partner admin

  Scenario: View authors
    Given some authors exist
    When I go to the authors page
    Then I should see a listing of all the authors
