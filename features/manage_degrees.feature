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

  Scenario: Create a new degree
    Given I am on the degrees page
    When I click the "Add a New Degree" link
    Then I should be on the new degree page
    When I fill in "Name" with "MArch"
    When I fill in "Description" with "Master of Architecture"
    When I fill in "Degree type" with "Master"
    And I check "Is active"
    And I press "Create Degree"
    Then I should be on the degrees page
    And I should see the degree MArch

  Scenario: Edit an existing degree
    Given some degrees exist
    And I am on the degrees page
    When I choose a degree to edit
    And I fill in "Name" with "MY-NEW-NAME"
    And I press "Update Degree"
    Then I should be on the degrees page
    And I should see the degree MY-NEW-NAME
