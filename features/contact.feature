Feature: Contact

  Background:
    Given there exist university organization
    And I am logged in as a student union employee
    Given there is a contact for an organization

  Scenario: Showing contact information
    Given I am at front page of 'Spartan Teknillinen Yliopisto'
    And I should see "Mr Contactabull halloped_contact@hyy.fi" as contact info
    And I should not see "+358 40 555 8899" as contact info
    When somebody creates an ongoing call
    And I refresh the page
    Then I should see "+358 40 555 8899" as contact info

  Scenario: Adding and removing a contact
    Given I am at front page of 'Spartan Teknillinen Yliopisto'
    And I press the "Add contact" button
    Then I fill in name, email and phone number fields with "Halloped contact", "halloped@stu.fi" and "+358666"
    And I press the save button
    Then I should see "Halloped contact halloped@stu.fi" as contact info 
    When I delete the first contact
    Then I should not see "Mr Contactabull halloped_contact@hyy.fi" as contact info
