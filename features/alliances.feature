Feature: Handling electoral alliances

  Background:
    Given there is open call for applications called 'Student council board members' in Helsingin yliopisto
    And there is open call for applications called 'Alumni council board members call' in Helsingin yliopisto
    And 'Helsingin yliopisto' has enabled alliances

  @javascript
  Scenario: Creating an alliance and sending confirmation emails
    Given I am logged in as a Helsinki university students' union employee
    And there is an application with deputy for "Student council board members"
    And there are applications for "Alumni council board members call" by Helsinki uni students:
      | tiina |
    And there are applications for "Student council board members" by Helsinki uni students:
      | with_no_phone |
    When I am at front page of 'Helsingin yliopisto'
    And I follow "Vaaliliitot"
    And I follow "Luo uusi vaaliliitto"
    And I fill in "MyAlliance" for "Nimi"
    And I select "Alumni council board members call" from "Haku"
    And I check "Tiina Miettinen (jäsen)" for call "Alumni council board members call"
  #By selecting another call we're checking that earlier application selections are not submitted along the form - alliance with applications from different calls would not be valid and thus could not be created.
    And I select "Student council board members" from "Haku"
    And I check "Markku Nophone" for call "Student council board members"
    And I check "Pekka Jantunen (jäsen) ja Anna Kainulainen (varajäsen)" for call "Student council board members"
    And I press "Lähetä"
    Then I should see "Vaaliliitto luotu"
    And I should see "Markku Nophone" listed as member
    And I should see "Pekka Jantunen" listed as member
    And I should see "Anna Kainulainen" listed as member
    And "nophone@helsinki.fi" should receive an email
    And "anna.kainulainen@helsinki.fi" should receive an email
    And "pekka@helsinki.fi" should receive an email

  Scenario: Creating an empty alliance
    Given I am logged in as a Helsinki university students' union employee
    And there is an application with deputy for "Student council board members"
    When I am at front page of 'Helsingin yliopisto'
    And I follow "Vaaliliitot"
    And I follow "Luo uusi vaaliliitto"
    And I fill in "MyAlliance" for "Nimi"
    And I select "Student council board members" from "Haku"
    And I press "Lähetä"
    Then I should see "Vaaliliitto luotu"

  Scenario: Confirming an alliance membership and resigned from an alliance
    And I am logged in as helsinki university student Anna
    Given someone has added my application to an electoral alliance called "Alliance1"
    And I follow "Helsingin yliopisto"
    When I follow "Vaaliliitot"
    And I follow "Alliance1" in the sidebar
    Then I should see my name among the unconfirmed members
    Then I should not see my name among the confirmed members
    And I should see "Sinulla on vahvistamattomia vaaliliittokutsuja"
    When I close the dialog
    And I press "Liity"
    Then I should not see "Sinulla on vahvistamattomia vaaliliittoja" in the sidebar
    And I should see "Vaaliliittoon kuuluminen vahvistettiin."
    And I follow "Alliance1" in the sidebar
    Then I should see my name among the confirmed members
    Then I should not see my name among the unconfirmed members
    When I close the dialog
    And I press "Eroa"
    Then I should see "Olet eronnut vaaliliitosta."
    And I should see "Sinulla on vahvistamattomia vaaliliittokutsuja"
    When I follow "Alliance1" in the sidebar
    Then I should see my name among the unconfirmed members
    Then I should not see my name among the confirmed members

  Scenario: Hide Alliances
    Given I am logged in as helsinki university student Anna
    And someone has added my application to an electoral alliance called "Alliance1"
    When I follow "Helsingin yliopisto"
    Then I should see "Sinulla on vahvistamattomia vaaliliittokutsuja"
    When all alliances have been archived
    And I refresh the page
    Then I should not see "Sinulla on vahvistamattomia vaaliliittokutsuja"
