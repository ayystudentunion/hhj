Feature: Login

  Background:
    Given there exist university organization
    And I am viewing the front page

  Scenario: Student union employee logs in
    Then I should see logged in user "Eija Zitting" with mail "eija.zitting@ayy.fi" and phone "+358 40 123 1234"
