Feature: Handling electoral alliances

  Background:
    Given there is open call for applications called 'Student council board members' in Helsingin yliopisto
    And there is open call for applications called 'Alumni council board members call' in Helsingin yliopisto
    And 'Helsingin yliopisto' has enabled alliances

  @javascript
  Scenario: Creating an alliance and sending confirmation emails
    When I am logged in as a Helsinki university students' union employee
    And there is an application with deputy for "Student council board members"
    And there are applications for "Alumni council board members call" by Helsinki uni students:
      | tiina | with_no_phone |
    And I am at front page of 'Helsingin yliopisto'
    And I follow "Vaaliliitot"
    And I follow "Luo uusi vaaliliitto"
    And I fill in "MyAlliance" for "Nimi"
    And I select "Student council board members" from "Haku"
    And I check "Pekka Jantunen (jäsen, varajäsen: Anna Kainulainen)" for call "Student council board members"
    And I check "Anna Kainulainen (varajäsen, jäsen: Pekka Jantunen)" for call "Student council board members"
    Then I should see "Olet valinnut vaaliliittoon maksimimäärän henkilöitä. Et voi valita enempää, koska haussa on vain 2 paikkaa tarjolla."
  #By selecting another call we're checking that earlier application selections are not submitted along the form - alliance with applications from different calls would not be valid and thus could not be created.
    When I select "Alumni council board members call" from "Haku"
    And I check "Markku Nophone" for call "Alumni council board members call"
    Then I should see "Olet valinnut vaaliliittoon maksimimäärän henkilöitä. Et voi valita enempää, koska haussa on vain 1 paikkaa tarjolla."
    And I press "Lähetä"
    Then I should see "Vaaliliitto luotu"
    Then I should see "Markku Nophone" listed as member
    Then "nophone@helsinki.fi" should receive an email

  Scenario: Confirming an alliance membership
    And I am logged in as helsinki university student Anna
    Given someone has added my application to an electoral alliance called "Alliance1"
    And I follow "Helsingin yliopisto"
    When I follow "Vaaliliitot"
    And I follow "Alliance1" in the sidebar
    Then I should see my name among the unconfirmed members
    Then I should not see my name among the confirmed members
    And I should see "Sinulla on vahvistamattomia vaaliliittokutsuja"
    When I press "Liity"
    Then I should not see "Sinulla on vahvistamattomia vaaliliittoja" in the sidebar
    And I should see "Vaaliliittoon kuuluminen vahvistettiin."
    And I follow "Alliance1" in the sidebar
    Then I should see my name among the confirmed members
    Then I should not see my name among the unconfirmed members
