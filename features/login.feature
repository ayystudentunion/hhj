Feature: Login

  Background:
    Given there exist university organization
    And I am logged in as a student union employee
    And there is a student union employee marked as contactable

  Scenario: Student union employee logs in
    Given I am at front page of 'Spartan Teknillinen Yliopisto'
    Then I should see logged in user "Eija Zitting" with mail "eija.zitting@sty.fi" and phone "+358 40 123 1234"
    And I should see "Lisätietoa"
    And I should see "Eija Zitting: eija.zitting@sty.fi"


