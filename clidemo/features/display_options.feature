# See github.com/cucumber/aruba/blob/master/lib/aruba/cucumber.rb for a list of all predefined steps

Feature: Test cli applications with Aruba

  In order to test command-line applications
  As a developer using BDD
  I want to use Aruba's predefined step definitions

  Scenario: Display options with the --help flag
    When I successfully run `02_linenum --help`
    Then the output should contain:
      """
      Usage: 02_linenum [options] files...
      """

  Scenario: Version
    When I successfully run `02_linenum --version`
    Then the output should contain "linenum"
    And the output should match /linenum ([\d]+\.[\d]+\.[\d]+)/

  Scenario: Display an error message if the argument is not a file
    When I run `02_linenum nonexistant.txt`
    Then the stderr should contain "Can't find"
    And the exit status should not be 0

