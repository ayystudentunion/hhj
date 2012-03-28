Feature: Creating a new organ

  Background:
    Given there exist university organization
    And I am logged in as a student union employee
    And I am viewing the front page

  @wip @selenium
  Scenario: Student union employee creates new organ
    When I press "Luo uusi toimielin"
    And fill in form "Luo uusi toimielin":
      |  label                           | value                                                            |
      |  Toimielimen nimi                | Tasa-arvotyöryhmä                                                |
      |  Kuvaus toimielimen toiminnasta  | Työryhmä varmistaa tasa-arvon toteutumisen                       |
      |  Toimikauden alkamisaika:        | 2012-01-01                                                       |
      |  Toimikauden päättymisaika:      | 2012-07-01                                                       |
      |  Valitse organisaatioyksikkö     | Luonnontieteellinen tiedekunta/Fysiikan laitos+Lakisääteinen     |

    And I press "Tallenna"
    Then I should see "Esittely" of organ "Tasa-arvotyöryhmä"
    And organ's organization is "Luonnontieteellinen tiedekunta/Fysiikan laitos"
    And organ's description is "Työryhmä varmistaa tasa-arvon toteutumisen"
    And organ's term is 2012-01-01 to 2012-07-01

  @ignore
  Scenario: Studen union employee cancels creation of organ

