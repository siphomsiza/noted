Feature: Setup Management

    Scenario: Successfully Setup Departments
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on Master Setup page
        When I follow "Departments"
        Then I should be on Department Setup page
        When I fill in "department[name]" with "My new Department"
        And I fill in "department[tel_no]" with "0764338939"
        And I fill in "department[fax_no]" with "0833128067"
        And I press "Save"
        Then I should see "Department record was not created."
        And should be on Department Setup page

    Scenario: Successfully Setup Departments with Sub-departments
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on Master Setup page
        When I follow "Departments"
        Then I should be on Department Setup page
        When I fill in "department[name]" with "My new Department"
        And I fill in "department[tel_no]" with "0764338939"
        And I fill in "department[fax_no]" with "0833128067"
        And I follow "Add Subdepartment"
        Then I fill in "subdepartment[name]" with "My new Sub-department"
        And I press "Save"
        Then I should see "Department record was successfully created."
        And should be on Department Setup page

    Scenario: Unsuccessful Department Setup
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on Master Setup page
        When I follow "Departments"
        Then I should be on Department Setup page
        When I fill in "department[name]" with ""
        And I fill in "department[tel_no]" with ""
        And I fill in "department[fax_no]" with ""
        And I press "Save"
        Then I should see "Department record was not created."
        And should be on Department Setup page

    Scenario: Unsuccessful Department Setup with Sub-departments
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on Master Setup page
        When I follow "Departments"
        Then I should be on Department Setup page
        When I fill in "department[name]" with ""
        And I fill in "department[tel_no]" with ""
        And I fill in "department[fax_no]" with ""
        Then I follow "Add Subdepartment"
        And I fill in "subdepartment[name]" with ""
        And I press "Save"
        Then I should see "Department record was not created."
        And should be on Department Setup page

    Scenario: Successfully Setup System
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on Master Setup page
        When I follow "System Setup"
        Then I should be on System Setup page
        When I check "setup[name]"
        And I press "Save"
        Then I should see "Setup saved successfully."
        And should be on System Setup page
