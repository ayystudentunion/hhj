Feature: Handling electoral alliances

  Background:
    Given there is open call for applications called 'Kirjakerhon lukurinki'
    Given there is open call for applications called 'Kirjakerhon uimarinki'
    And 'Spartan Teknillinen Yliopisto' has enabled alliances

  Scenario: Creating an alliance
    Given I am logged in as a student union employee
    And there are 3 applications for "Kirjakerhon lukurinki"
    And there are 3 applications for "Kirjakerhon uimarinki"
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
    Given someone has added my application to an electoral alliance called "Alliance1"
    And I follow "Spartan Teknillinen Yliopisto"
    When I follow "Vaaliliitot"
    And I follow "Alliance1"
    Then I should see my name among the unconfirmed members
    Then I should not see my name among the confirmed members
    And I should see "Sinulla on vahvistamattomia vaaliliittokutsuja"
    When I press "Liity"
    Then I should not see "Sinulla on vahvistamattomia vaaliliittoja" in the sidebar
    And I should see "Vaaliliittoon kuuluminen vahvistettiin."
    When I refresh the page
    And I follow "Alliance1"
    Then I should see my name among the confirmed members
    Then I should not see my name among the unconfirmed members
