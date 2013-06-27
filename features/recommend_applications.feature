Feature: Recommending a position application

  Background:
    Given there is open call for applications called 'Kirjakerhon lukurinki'
    And there is an application with deputy for "Kirjakerhon lukurinki"

  Scenario: Recommending another application
    Given I am logged in as a student union employee
    And "Spartan Teknillinen Yliopisto" has enabled recommendations with threshold of 1
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of call 'Kirjakerhon lukurinki'
    Then I should see 1 button with text "Suosittele"
    Then I press 'Suosittele'
    Then I press 'Peru suosittelu'
    Then I press 'Suosittele'
    And I navigate to home page of organ 'Kirjakerho'
    Then I should see "Suosittelut: 1/1"

  Scenario: Not seeing a recommend link to user's own application
    Given "Spartan Teknillinen Yliopisto" has enabled recommendations with threshold of 1
    And I am logged in as a student
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of call 'Kirjakerhon lukurinki'
    Then I should see "Martti Pulliainen (varajäsen: Tiina Kumpulainen)"
    And I should see 0 buttons with text "Suosittele"

  Scenario: Not seeing a recommend link to for the application a user is deputy of
    Given "Spartan Teknillinen Yliopisto" has enabled recommendations with threshold of 1
    And I am logged in as user student tiina
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of call 'Kirjakerhon lukurinki'
    Then I should see "Martti Pulliainen (varajäsen: Tiina Kumpulainen)"
    And I should see 0 buttons with text "Suosittele"

  Scenario: Not seeing a recommend link to for the application a user is deputy of
    Given "Spartan Teknillinen Yliopisto" has enabled recommendations with threshold of 1
    And I am logged in as user student tiina
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of call 'Kirjakerhon lukurinki'
    Then I should see "Martti Pulliainen (varajäsen: Tiina Kumpulainen)"
    And I should see 0 buttons with text "Suosittele"

  Scenario: Not seeing a recommend link if the university hasn't enabled recommendations
    Given I am logged in as a student union employee
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of call 'Kirjakerhon lukurinki'
    Then I should see 0 buttons with text "Suosittele"
