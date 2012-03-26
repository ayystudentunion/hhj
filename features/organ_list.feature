Feature: Viewing a list of organs

  Background:
    Given I am viewing the front page
    And there are several organs in the system

  Scenario: Visiting the organ list
    When I follow the link "Toimielimet"
    Then I should see a list of organs