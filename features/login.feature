Feature: Login

  Background:
    Given there exist university organization
    And I am logged in as a student union employee

  Scenario: Student union employee logged in
    Given I am at front page of 'Spartan Teknillinen Yliopisto'
    Then I should see logged in user "Eija Zitting" with mail "eija.zitting@sty.fi" and phone "+358 40 123 1234"

  Scenario: Logging out
    And I logout
    Then I should see "Kirjaudu yliopistosi käyttäjätunnuksilla"
    And I should not see "Omat tiedot"




