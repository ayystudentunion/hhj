Feature: Creating a new organ

  Background:
    Given there exist university organization
    And I am logged in as a member of university staff
    And I am at front page of 'Spartan Teknillinen Yliopisto'

  Scenario: Staff member creates new organs
    When I press 'Luo uusi toimielin'
    And I fill in form 'Luo uusi toimielin':
      |  label                           | value                                                            |
      |  Toimielimen nimi                | Tasa-arvotyöryhmä                                                |
      |  Kuvaus toimielimen toiminnasta  | Työryhmä varmistaa tasa-arvon toteutumisen                       |
      |  Toimikauden alkamisaika:        | 2012-01-01                                                       |
      |  Toimikauden päättymisaika:      | 2012-07-01                                                       |
      |  Vastuuhenkilön nimi             | Saima Salminen                                                   |
      |  Vastuuhenkilön sähköpostiosoite | saima@halloped.fi                                                |
      |  Nimityksen tekevä henkilö       | Dekaani                                                          |
      |  Valitse organisaatioyksikkö     | Luonnontieteellinen tiedekunta/Fysiikan laitos+Lakisääteinen     |

    And I press 'EN'
    And I fill in form 'Luo uusi toimielin':
      |  label                             | value                                                            |
      |  Organ name                        | Equality organ                                                   |
      |  Description on organ's operations | Organ assures fulfilling of equality                             |

    And I press 'Tallenna'

    Then I should see introduction of organ 'Tasa-arvotyöryhmä' with description 'Työryhmä varmistaa tasa-arvon toteutumisen':
      |  label                           | value                                                            |
      |  Toimikausi                      | 01.01.2012 - 01.07.2012                                          |
      |  Vastuuhenkilö                   | Saima Salminen                                                   |
      |  Organisaatioyksikkö             | Luonnontieteellinen tiedekunta - Fysiikan laitos                 |

    And I change language to 'en'
    Then I should see introduction of organ 'Equality organ' with description 'Organ assures fulfilling of equality':
      |  label                           | value                                                            |
      |  Term                            | 2012-01-01 - 2012-07-01                                          |
      |  Person in charge                | Saima Salminen                                                   |

