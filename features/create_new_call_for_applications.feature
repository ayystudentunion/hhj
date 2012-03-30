Feature: Creating new call for applications for organ

  Background:
    Given there exists an organ 'Tasa-arvotyöryhmä'
    And I am logged in as a student union employee
    And I am in home page or organ 'Tasa-arvotyöryhmä'

  Scenario:
    When I press 'Avaa uusi paikkahaku'

