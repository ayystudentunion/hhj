@ignore
Feature: Applying for a position

  Background:
    Given I am logged in as a student
    And there exists a call for applications for an organ
    And I am in that organ's home page

  Scenario: Submitting an application
    When I press 'Lähetä hakemus'
    Then I should see my own name, phone number and email-address in the application form

    When I press 'Jäsen'
    And fill in the application fields
    And press 'Lähetä'

    Then I should see 'Hakemus lähetetty'
