Feature: Handling electoral alliances

  Background:
    Given there is open call for applications called 'Kirjakerhon lukurinki'
    Given there is open call for applications called 'Kirjakerhon uimarinki'

  Scenario: Creating an alliance
    Given I am logged in as a student union employee
    And there are 3 applications for "Kirjakerhon lukurinki"
    And there are 3 applications for "Kirjakerhon uimarinki"
    And 'Spartan Teknillinen Yliopisto' has enabled alliances
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I follow "Vaaliliitot"
    When I follow "Luo uusi vaaliliitto"
    And I fill in "MyAlliance" for "Nimi"
    And I check "Martti Pulliainen"
    And I check "Topias Lapinmaa"
    #By selecting another call we're checking that earlier selections are not submitted along the form - alliance with applications from different calls would not be valid and thus could not be created.
    And I select "Kirjakerhon uimarinki" from "Haku"
    And I check "Martti Pulliainen"
    And I check "Topias Lapinmaa"
    And I press "Lähetä"
    Then I should see "Vaaliliitto luotu"
    Then I should see "Martti Pulliainen" listed as member
    Then I should see "Topias Lapinmaa" listed as member

  Scenario: Confirming an alliance membership
    Given I am logged in as a student
    Given someone has added my application to an electoral alliance
    And I follow "Spartan Teknillinen Yliopisto"
    Then I should see "Sinulla on vahvistamattomia vaaliliittokutsuja"
    When I follow "Vahvista"
    Then I should not see "Sinulla on vahvistamattomia vaaliliittoja" in the sidebar
    Then I should see "Vaaliliittoon kuuluminen vahvistettiin."
