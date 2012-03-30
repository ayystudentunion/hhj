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
      |  Toimikauden alkamisaika:           | 2012-02-02                                                |
      |  Toimikauden päättymisaika:         | 2012-06-30                                                |
      |  Päätöksenteon paikka ja ajankohta  | Yliopiston ohjausryhmän kokous tammikuussa                |


    And I press 'EN'
    And fill in form 'Avaa uusi paikkahaku toimielimelle':
      |  label                           | value                                                            |
      |  Title of call for applications  | Call for new representatives for Equality organ in term 2013     |
      |  Halloped job description        | Lobbying the interests of students in equality                   |

    And I press 'Tallenna'
