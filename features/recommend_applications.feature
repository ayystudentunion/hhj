Feature: Recommending a position application

  Background:
    Given there is open call for applications called 'Student council board members' in Helsingin yliopisto
    And there is an application with deputy for "Student council board members"

  Scenario: Recommending another application and looking and one application's information card
    Given the member application has one confirmed alliance and one unconfirmed alliance
    And I am logged in as helsinki university student Tiina
    And "Helsingin yliopisto" has enabled recommendations with threshold of 1
    And I am at front page of 'Helsingin yliopisto'
    And I navigate to home page of call 'Student council board members'
    #it's important that there's only one button so that we know it can be toggled:
    Then I should see 1 button with text "Aseta"
    When I press 'Aseta'
    And I press 'Peru asettaminen'
    And I press 'Aseta'
    When I follow the link 'Pekka Jantunen'
    Then I should see "Suosittelut: Tiina Miettinen (tiina.miettinen@helsinki.fi)"
    Then I should see "Vahvistamattomat vaaliliitot: Alliance1"
    Then I should see "Vaaliliitot: Alliance2"
    Given I am logged in as a Helsinki university students' union employee
    And I am at front page of 'Helsingin yliopisto'
    And I navigate to home page of organ 'Helsingin yliopiston opiskelijahallitus'
    Then I should see "Suosittelut: 1/1"

  Scenario: Not seeing a recommend link to user's own application
    Given "Helsingin yliopisto" has enabled recommendations with threshold of 1
    And I am logged in as helsinki university student Pekka
    And I am at front page of 'Helsingin yliopisto'
    And I navigate to home page of call 'Student council board members'
    Then I should see "Pekka Jantunen (jäsen, varajäsen: Anna Kainulainen)"
    And I should see 0 buttons with text "Aseta"

  Scenario: Not seeing a recommend link to for the application a user is deputy of
    Given "Helsingin yliopisto" has enabled recommendations with threshold of 1
    And I am logged in as helsinki university student Anna
    And I am at front page of 'Helsingin yliopisto'
    And I navigate to home page of call 'Student council board members'
    Then I should see "Pekka Jantunen (jäsen, varajäsen: Anna Kainulainen)"
    And I should see 0 buttons with text "Aseta"

  Scenario: Not seeing a recommend link if the university hasn't enabled recommendations
    And I am logged in as a Helsinki university students' union employee
    And I am at front page of 'Helsingin yliopisto'
    And I navigate to home page of call 'Student council board members'
    Then I should see 0 buttons with text "Aseta"
