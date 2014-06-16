Feature: Manage authors
  As a partner admin
  I should be able to view and edit authors
  So that my school has up-to-date author information

  Background:
    Given I am a partner admin

  Scenario: View authors
    Given some authors exist
    When I go to the authors page
    Then I should see a listing of all the authors

  Scenario: Edit an existing author
    Given some authors exist
    And I am on the authors page
    When I choose an author to edit
    And I fill in "First name" with "NEW-FIRST-NAME"
    And I modify the rest of author's attributes
    And I press "Update Author"
    Then I should be on the authors page
    And I should see the author NEW-FIRST-NAME
