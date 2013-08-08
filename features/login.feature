Feature: Login

  Background:
    Given there exist university organization
    And I am logged in as a student union employee

  Scenario: Student union employee logs in
    Given I am at front page of 'Spartan Teknillinen Yliopisto'
    Then I should see logged in user "Eija Zitting" with mail "eija.zitting@sty.fi" and phone "+358 40 123 1234"

  Scenario: Showing contact information
    And there is a student union employee marked as contactable and contactable by phone
    Given I am at front page of 'Spartan Teknillinen Yliopisto'
    And I should see "Eija Zitting eija.zitting@sty.fi" as contact info
    And I should not see "+358 40 123 1234" as contact info
    When somebody creates an ongoing call
    And I refresh the page
    Then I should see "+358 40 123 1234" as contact info




