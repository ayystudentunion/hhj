Feature: Creating new call for applications for organ

  Background:
    Given there is open call for applications called 'Student council board members' in Helsingin yliopisto
    And there is an application with deputy for "Student council board members"
    Given I am logged in as a Helsinki university students' union employee
    And I am at front page of 'Helsingin yliopisto'

  #This tests that the pdf is downloaded without errors:
  @rack_test
  Scenario: Printing calls
    When I press 'Tulosta'
