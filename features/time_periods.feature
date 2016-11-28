Feature: SDBIP Time Periods

    Background: Logged in Successfully as a user
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."
        Given I am on the introduction page

    Scenario: Browse Time Periods
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Create Time Period(s)"

    Scenario: Add/Create Time Periods with valid data
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Create Time Period(s)"
        When I follow "Create Time Period(s)"
        Then I should be on the add time period page
        And I should see "New Time Period"
        When I fill in "sdbip_time_period[period]" with "10/12/2016"
        When I fill in "sdbip_time_period[primary_reminder]" with "10/12/2016"
        When I fill in "sdbip_time_period[primary_closure]" with "10/12/2016"
        When I fill in "sdbip_time_period[secondary_reminder]" with "10/12/2016"
        When I fill in "sdbip_time_period[secondary_closure]" with "10/12/2016"
        And I press "Save"
        Then I should be on the time periods page
        And should see "Sdbip Time Period was successfully created."

    Scenario: Add/Create Time Periods with invalid data
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Create Time Period(s)"
        When I follow "Create Time Period(s)"
        Then I should be on the add time period page
        And I should see "New Time Period"
        When I fill in "sdbip_time_period[period]" with ""
        When I fill in "sdbip_time_period[primary_reminder]" with ""
        When I fill in "sdbip_time_period[primary_closure]" with ""
        When I fill in "sdbip_time_period[secondary_reminder]" with ""
        When I fill in "sdbip_time_period[secondary_closure]" with ""
        And I press "Save"
        Then I should be on the time periods page
        And should see "Sdbip Time Period was not created."

    Scenario: Edit Time Periods
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Update Period"
        When I follow "Update Period"
        Then I should be on edit time period page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Status"
        And I should see "Reminder"
        When I fill in "sdbip_time_period[finance_reminder]" with "15/12/2016"
        When I fill in "sdbip_time_period[finance_closure]" with "22/12/2016"
        And I press "Save"
        Then I should be on the time periods page
        And should see "Sdbip Time Period was successfully updated."

    Scenario: Close Primary Time Periods
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Update Period"
        When I follow "Update Period"
        Then I should be on edit time period page
        And I should see "Close Primary"
        When I follow "Close Primary"
        Then I should be on the time periods page
        And should see "Time periods closed successfully."

    Scenario: Close Secondary Time Periods
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Update Period"
        When I follow "Update Period"
        Then I should be on edit time period page
        And I should see "Close Secondary"
        When I follow "Close Secondary"
        Then I should be on the time periods page
        And should see "Time periods closed successfully."

    Scenario: Close Finance Time Periods
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Update Period"
        When I follow "Update Period"
        Then I should be on edit time period page
        And I should see "Close Finance"
        When I follow "Close Finance"
        Then I should be on the time periods page
        And should see "Time periods closed successfully."

    Scenario: Successfully Import SDBIP Time Periods
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Import Time Periods"
        When I press "Import Time Periods"
        Then I should be on the import time periods page
        And I should see "Setup SDBIP Time Period Importing SDBIP Time Periods"
        When I attach the file "../../time_periods.xlsx" to "file"
        And I press "Import"
        Then I should be on the time periods page
        And should see "Time periods imported successfully."

    Scenario: Unsuccessfully Import SDBIP Time Periods
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Import Time Periods"
        When I press "Import Time Periods"
        Then I should be on the import time periods page
        And I should see "Setup SDBIP Time Period Importing SDBIP Time Periods"
        When I press "Import"
        Then I should be on the time periods page
        And should see "You have not selected a file"

    Scenario: Successful Update All Automatic Time Periods with valid Data
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Update All Automatic Time Periods"
        When I press "Update All Automatic Time Periods"
        Then I should be on the update all automatic time periods page
        And I should see "Setup SDBIP Time Periods Update Time Periods"
        When I fill in "primary_reminder" with 5
        When I fill in "primary_closure" with 7
        When I fill in "secondary_reminder" with 5
        When I fill in "secondary_closure" with 7
        And I press "Submit"
        Then I should be on the time periods page
        And should see "All automatic time periods updated successfully."

    Scenario: Unsuccessful Update All Automatic Time Periods with invalid Data
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Time Periods"
        When I follow "Time Periods"
        Then I should be on the time periods page
        And I should see "Primary"
        And I should see "Secondary"
        And I should see "Finance"
        And I should see "Update All Automatic Time Periods"
        When I press "Update All Automatic Time Periods"
        Then I should be on the update all automatic time periods page
        And I should see "Setup SDBIP Time Periods Update Time Periods"
        When I fill in "primary_reminder" with ""
        When I fill in "primary_closure" with ""
        When I fill in "secondary_reminder" with ""
        When I fill in "secondary_closure" with ""
        And I press "Submit"
        Then I should be on the time periods page
        And should see "All automatic time periods were not updated."

    Scenario: Send Notification to update KPI
        Given I am on the login page
        When I go to the send kpi owner notifications page
        Then I should be on the login page

    Scenario: Auto Close Time Periods
        Given I am on the login page
        When I go to the update time period status page
        Then I should be on the login page
