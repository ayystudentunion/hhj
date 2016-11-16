Feature: Editing an existing organ

  Background:
    Given there exists an organ 'Tasa-arvotyöryhmä'
    And I am logged in as a member of university staff
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of organ 'Tasa-arvotyöryhmä'

  Scenario: Staff member fails to edit en existing organ
    When I press the edit icon for 'Tasa-arvotyöryhmä'
    And I fill in form 'Muokkaa toimielintä':
      |  label                           | value                                                            |
      |  Toimielimen nimi                |                                                                  |
    And I press 'Tallenna'
    Then I should see "Puutteellinen toimielin"

  Scenario: Staff member edits an existing organ
    When I press the edit icon for 'Tasa-arvotyöryhmä'
    And I fill in form 'Muokkaa toimielintä':
      |  label                           | value                                                            |
      |  Toimielimen nimi                | Tasa-arvon työryhmä                                              |
      |  Toimikauden alkamisaika:        | 2012-03-02                                                       |
      |  Toimikauden päättymisaika:      | 2012-08-04                                                       |
      |  Vastuuhenkilön nimi             | Soini Salminen                                                   |
      |  Vastuuhenkilön sähköpostiosoite | soini@halloped.fi                                                |
      |  Nimityksen tekevä taho          | Dekaani                                                          |
      |  Valitse organisaatioyksikkö     | Luonnontieteellinen tiedekunta/Kemian laitos+Lakisääteinen       |

    And I press 'EN'
    And I fill in form 'Muokkaa toimielintä':
      |  label                           | value                                                            |
      |  Organ name                      | Organ of Equality                                                |

    And I press 'Tallenna'

    Then I should see introduction of organ 'Tasa-arvon työryhmä' with description 'Työryhmä varmistaa tasa-arvon toteutumisen':
      |  label                           | value                                                            |
      |  Toimikausi                      | 02.03.2012 - 04.08.2012                                          |
      |  Vastuuhenkilö                   | Soini Salminen                                                   |
      |  Organisaatioyksikkö             | Luonnontieteellinen tiedekunta - Kemian laitos                 |

    And I change language to 'en'
    Then I should see introduction of organ 'Organ of Equality' with description 'Organ assures fulfilling of equality':
      |  label                           | value                                                            |
      |  Term                            | 2012-03-02 - 2012-08-04                                          |
      |  Person in charge                | Soini Salminen                                                   |

