Feature: Introduction

    Background: Logged in Successfully as a user
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."

    Scenario: View Introduction page
        Given I am on the introduction page
        Then I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"

    Scenario: Navigate to Dashboard page
        Given I am on the introduction page
        Then I should see "Lepelle Nkumpi Local Municipality"
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "Get Started"
        Then I should be on the dashboard page
        And I should see "SDBIP Time Periods"
        And I should see "Users Statistics"
        And I should see "Activity Log"

    Scenario: Given I have not logged in
        Given I am on the login page
        When I go to the introduction page
        Then I should be on the login page
        And I should see "Please log in."
