Feature: Login

  Background:
    Given there exist university organization
    And I am logged in as a student union employee

  Scenario: Student union employee logged in
    Given I am at front page of 'Spartan Teknillinen Yliopisto'
    Then I should see logged in user "Eija Zitting" with mail "eija.zitting@sty.fi" and phone "+358 40 123 1234"

  Scenario: Showing contact information
    And there is a student union employee marked as contactable and contactable by phone
    Given there is a contact for an organization
    Given I am at front page of 'Spartan Teknillinen Yliopisto'
    And I should see "Mr Contactabull halloped_contact@hyy.fi" as contact info
    And I should not see "+358 40 555 8899" as contact info
    When somebody creates an ongoing call
    And I refresh the page
    Then I should see "+358 40 555 8899" as contact info

  Scenario: Logging out
    And I logout
    Then I should see "Kirjaudu yliopistosi käyttäjätunnuksilla"
    And I should not see "Omat tiedot"




