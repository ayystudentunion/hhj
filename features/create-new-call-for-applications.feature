Feature: Creating new call for applications for organ

  Background:
    Given there exists an organ
    And I am logged in as a student union employee
    And I am in that organ's home page

  Scenario:
    When I press 'Avaa uusi paikkahaku'
    And
