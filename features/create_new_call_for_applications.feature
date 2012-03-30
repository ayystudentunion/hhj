Feature: Creating new call for applications for organ

  Background:
    Given there exists an organ 'Tasa-arvotyöryhmä'
    And I am logged in as a student union employee
    And I am in home page or organ 'Tasa-arvotyöryhmä'

  Scenario:
    When I press 'Avaa uusi paikkahaku'
    And fill in form 'Avaa uusi paikkahaku toimielimelle':
      |  label                              | value                                                     |
      |  Paikkahaun otsikko                 | Haetaan uusia edustajia Tasa-arvotyöryhmään kaudelle 2013 |
      |  Kuvaus hallopedin työnkuvasta      | Valvoa opiskelijoiden etua tasa-arvon toteutumassa        |
      |  Varsinaisia jäseniä                | 3                                                         |
      |  Varajäseniä                        | 1                                                         |
      |  Haun avaamispäivämäärä             | 2012-01-01                                                |
      |  Haun alkamispäivämäärä             | 2012-01-02                                                |
      |  Haun päättymispäivämäärä           | 2012-01-20                                                |
      |  Toimikauden alkamisaika            | 2012-02-02                                                |
      |  Toimikauden päättymisaika          | 2012-06-30                                                |
      |  Päätöksenteon paikka ja ajankohta  | Yliopiston ohjausryhmän kokous tammikuun lopussa          |
      |  Lisätietoa käsittelijälle          | Ainakin yksi nainen ja yksi mies                          |

    And I press 'EN'
    And fill in form 'Avaa uusi paikkahaku toimielimelle':
      |  label                              | value                                                            |
      |  Title of call for applications     | Call for new representatives for Equality organ in term 2013     |
      |  Halloped job description           | Lobbying the interests of students in equality                   |
      |  Additional information for handler | At least one woman and one man                                   |

    And I press 'Tallenna'

    Then I should see call for application 'Haetaan uusia edustajia Tasa-arvotyöryhmään kaudelle 2013' with description 'Valvoa opiskelijoiden etua tasa-arvon toteutumassa':
      |  label                              | value                                                            |
      |  Toimikausi                         | 02.02.2012 - 30.06.2012                                          |
      |  Haetaan                            | 3 varsinaista jäsentä, yhtä varajäsentä                          |
      |  Haun avaamispäivämäärä             | 01.01.2012                                                       |
      |  Hakuaika                           | 02.01.2012 - 20.01.2012                                          |
      |  Toimikausi                         | 02.02.2012 - 30.06.2012                                          |
      |  Päätöksenteon paikka ja ajankohta  | Yliopiston ohjausryhmän kokous tammikuun lopussa                 |

    And I change language to 'en'
    Then I should see call for application 'Call for new representatives for Equality organ in term 2013' with description 'Lobbying the interests of students in equality':
      |  label                           | value                                                            |
      |  Term                            | 2012-02-02 - 2012-06-30                                          |
