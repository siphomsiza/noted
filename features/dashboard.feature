Feature: Dashboard

    Background: Given I go to login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        Then I press "Log in"
        Then I should be on the introduction page

    Scenario: SDBIP Data is loaded
        Given I am on the introduction page
        Then I should see "DASHBOARD"
        When I follow "DASHBOARD"
        Then I should be on the dashboard page
        And I should not see "SDBIP Notice"
        And I should see "SDBIP Time Periods"
        And I should see "User Statistics"
        And I should see "Activity Log"

    Scenario: SDBIP Data is not loaded
        Given I am on the introduction page
        Then I should see "DASHBOARD"
        When I follow "DASHBOARD"
        Then I should be on the dashboard page
        And I should see "SDBIP Notice"
        And I should see "SDBIP Time Periods"
        And I should see "User Statistics"
        And I should see "Activity Log"
