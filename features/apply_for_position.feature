Feature: Applying for a position

  Scenario: Submitting an application
    Given I am logged in as a student
    And there is open call for applications called 'Kirjakerhon lukurinki'
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of call 'Kirjakerhon lukurinki'
    When I press 'Lähetä hakemus'
    Then I should see student martti's name, phone number and email-address in the application form
    Then I fill in form 'Lähetä hakemus':
      | label                      | value                                     |
      | Haen                       | Varajäseneksi                             |
      | Kenen varajäseneksi haluat | Tenho Taipale                             |
      | Perustelut                 | 3 vuoden kokemus Hallopedina toimimisesta |

    And I press 'Lähetä' within dialog

    Then I should see my own name, phone number and email-address in the confirmation dialog
    Then I should see dialog 'Hakemus lähetetty' with text '3 vuoden kokemus Hallopedina toimimisesta':
      | label                      | value         |
      | Haen                       | Varajäseneksi |
      | Kenen varajäseneksi haluat | Tenho Taipale |

    And I press 'Ok'

    Then I should see call for application 'Kirjakerhon lukurinki'

#These tests test the Helsinki university application process which is more complicated then other universities.
#Helsinki university has deputy candidates, a recommendation process and electoral alliances.
#This requires that a association between and deputy and member is formed whilst applying because recommendation and alliance features depend on this.
#You will find a template to generate the form fields for this association in public/universities/helsinki/_member_fields.
  @javascript
  Scenario: Submitting a member application in Helsinki university
    Given there is open call for applications called 'Student council board members' in Helsingin yliopisto
    And I am logged in as a helsinki university student Anna
    And I am at front page of 'Helsingin yliopisto'
    And I navigate to home page of call 'Student council board members'
    When I press 'Lähetä hakemus'
    Then I should see Helsinki uni student Anna's name, phone number and email-address in the application form
    When I fill in form 'Lähetä hakemus':
      | label      | value                                     |
      | Haen       | Jäseneksi                                 |
      | Perustelut | 3 vuoden kokemus Hallopedina toimimisesta |
    And I press 'Lähetä' within dialog
    Then I should see dialog 'Hakemus lähetetty' with text '3 vuoden kokemus Hallopedina toimimisesta':
      | label      | value                                     |
      | Haen       | Jäseneksi                                 |
    And I press 'Ok'
    And I should see call for application 'Student council board members'

  @javascript
  Scenario: Submitting a deputy application in Helsinki university
    Given there is open call for applications called 'Student council board members' in Helsingin yliopisto
    And "Helsingin yliopisto" has enabled recommendations with threshold of 3
    And there is an primary application for call 'Student council board members' by student Pekka of Helsingin yliopisto
    And there is an primary application for call 'Student council board members' by student Anna of Helsingin yliopisto
    And I am logged in as a helsinki university student Tiina
    And I am at front page of 'Helsingin yliopisto'
    When I navigate to home page of call 'Student council board members'
    And I press 'Lähetä hakemus'
    When I fill in form 'Lähetä hakemus':
      | label      | value                                     |
      | Haen       | Varajäseneksi                             |
      | Perustelut | 3 vuoden kokemus Hallopedina toimimisesta |
    And I select "Anna Kainulainen" as the member I want to be deputy of
    And I press 'Lähetä' within dialog
    And I press 'Ok'
    And I refresh the page
    Then I should see "Anna Kainulainen (varajäsen: Tiina Miettinen)" among the applications listing
    #you cannot recommend your own applications and applications without a deputy. Thus:
    Then I should see 0 buttons with text "Suosittele"
