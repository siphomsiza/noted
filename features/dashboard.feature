Feature: Dashboard

    Background: Log in Successfully As an Admin
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."

    Scenario: SDBIP Data is loaded
        Given I am on the introduction page
        Then I should see "DASHBOARD"
        When I follow "DASHBOARD"
        Then I should be on the dashboard page
        And I should not see "SDBIP Notice"
        And I should see "SDBIP Time Periods"
        And I should see "Users Statistics"
        And I should see "Activity Log"

    Scenario: SDBIP Data is not loaded
        When I go to introduction page
        Then I should see "DASHBOARD"
        When I follow "DASHBOARD"
        Then I should be on the dashboard page
        And I should see "SDBIP Time Periods"
        And I should see "Users Statistics"
        And I should see "Activity Log"
