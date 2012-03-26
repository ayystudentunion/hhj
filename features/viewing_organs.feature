Feature: Viewing organs

  Background:
    Given I am viewing the front page
    And there are several organs in the system

  Scenario: Visiting the organ list
    When I follow the link "Toimielimet"
    Then I should see a list of organs

  Scenario: Visiting the home page of a specific organ
    When I follow the link "Toimielimet"
    And I follow the link "Kirjakerho"

    Then I should see the organ page for "Kirjakerho"