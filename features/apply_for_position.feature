Feature: Applying for a position

  Background:
    Given I am logged in as a student
    And there is open call for applications called 'Kirjakerhon lukurinki'
    And I am in home page of call 'Kirjakerhon lukurinki'

  Scenario: Submitting an application
    When I press 'Lähetä hakemus'
    Then I should see my own name, phone number and email-address in the application form
    Then I fill in form 'Lähetä hakemus':
      |  label                              | value                                     |
      |  Haen                               | Varajäseneksi                             |
      |  Kenen varajäseneksi haluat         | Tenho Taipale                             |
      |  Perustelut                         | 3 vuoden kokemus Hallopedina toimimisesta |

    And I press 'Lähetä'

