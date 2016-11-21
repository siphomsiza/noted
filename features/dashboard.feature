Feature: Dashboard

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
