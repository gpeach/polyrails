Feature: kush lookup test
    
  @javascript
  Scenario: perform kush lookup
    Given I have the strain search form
    When I fill in kush
    And I submit the form
    Then results should include a paper-card element