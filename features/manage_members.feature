Feature: Manage members as an organ admin

  Background:
    Given there exists an organ 'Tasa-arvotyöryhmä'
    And I am logged in as a student union employee
    And a student exists
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of organ 'Tasa-arvotyöryhmä'

  Scenario: Adding a new member and deleting it
    When I press the edit icon within organ members
    And I fill in email field with "emma@spu.fi"
    And I press the plus
    And I follow the link 'Valmis'
    Then I should see "Emma Saarioinen"
    When I press the edit icon within organ members
    And I press the cross
    And I follow the link 'Valmis'
    Then I should not see "Emma Saarioinen"
