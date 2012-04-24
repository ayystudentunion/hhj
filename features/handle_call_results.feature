Feature: Handling the results of call for applications

  Background:
    Given there is open call for applications called 'Kirjakerhon lukurinki'
    And there are 3 applications for 'Kirjakerhon lukurinki'
    And I am logged in as a student union employee
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of organ 'Kirjakerho'

  Scenario: Student union employee handles results of call for application
    Then I should see 0 persons in 'Istuvat opiskelijaedustajat'
    And I press 'Sulje haku'
    Then I set applicant 'Martti' as 'Jäsen'
    And I set applicant 'Emma' as 'Varajäsen'
    And I press 'Hyväksy valinnat'

    Then I should see exactly the following persons in 'Istuvat opiskelijaedustajat':
    | name    | term             | position     |
    | Martti  | Toistaiseksi     | Jäsen        |
    | Emma    | Toistaiseksi     | Varajäsen    |

    Then I should see exactly the following persons in 'Valitut jäsenet':
    | name    |
    | Martti  |

    Then I should see exactly the following persons in 'Valitut varajäsenet':
    | name  |
    | Emma  |

    Then I should see exactly the following persons in 'Valitsematta jääneet':
    | name   |
    | Topias |

