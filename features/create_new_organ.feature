@ignore
Feature: Creating a new organ

  Background:
    Given I am logged in as a student union employee
    And I am viewing the front page

  Scenario: Student union employee creates new organ
    When I press "Lisää uusi toimielin"
    And fill in the typical values

    And fill in name as "Tasa-arvotyöryhmä"
    And fill in description as "Työryhmä varmistaa tasa-arvon toteutumisen"
    And choose the classification "Virallinen"
    And fill in term from 2012-01-01 to 2012-07-01
    And choose the organization "Luonnontieteellinen tiedekunta/Fysiikan laitos"
    And press "Tallenna"
    Then I should see "Esittely" of organ "Tasa-arvotyöryhmä"
    And organ's organization is "Luonnontieteellinen tiedekunta/Fysiikan laitos"
    And organ's description is "Työryhmä varmistaa tasa-arvon toteutumisen"
    And organ's term is 2012-01-01 to 2012-07-01

  Scenario: Studen union employee cancels creation of organ

