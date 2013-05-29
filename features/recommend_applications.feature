Feature: Recommending a position application

  Background:
    Given there is open call for applications called 'Kirjakerhon lukurinki'
    And there is an application for "Kirjakerhon lukurinki"

  Scenario: Recommending another application
    Given I am logged in as a student union employee
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of call 'Kirjakerhon lukurinki'
    Then I should see 1 button with text "Recommend"
    Then I press 'Recommend'
    Then I press 'Cancel recommendation'
    Then I press 'Recommend'

   Scenario: Not seeing a recommend link to your own application
     Given I am logged in as a student
     And I am at front page of 'Spartan Teknillinen Yliopisto'
     And I navigate to home page of call 'Kirjakerhon lukurinki'
     Then I should see 0 buttons with text "Recommend"
