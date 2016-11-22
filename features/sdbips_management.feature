Feature: SDBIP Management Module(s)

    Background: Log in Successfully As an Admin
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."

    Scenario: Add Departmental SDBIPs
        Given I am on the introduction page
        And I should see "SDBIP"
        When I follow "SDBIP"
        Then I should be on the departmental view page
        Given I am on the departmental view page
        And I should see "Who"
        And I should see "What"
        And I should see "When"
        When I follow "Add KPI"
        Then I should be on the add kpi page
        And I should see "New Departmental KPI"

    Scenario: Import Departmental SDBIPs

    Scenario: Browse Departmental SDBIPs
        Given I am on the introduction page
        And I should see "SDBIP"
        When I follow "SDBIP"
        Then I should be on the departmental view page
        Given I am on the departmental view page
        And I should see "Who"
        And I should see "What"
        And I should see "When"

    Scenario: Browse Deleted Departmental SDBIPs
        Given I am on the introduction page
        And I should see "SDBIP"
        When I follow "SDBIP"
        Then I should be on the departmental view page
        Given I am on the departmental view page
        When I follow "Deleted KPIs"
        Then I should be on the deleted kpis page
        And I should see "Deleted Departmental KPIs"

    Scenario: Restore Deleted Departmental SDBIPs
        Given I am on the introduction page
        And I should see "SDBIP"
        When I follow "SDBIP"
        Then I should be on the departmental view page
        Given I am on the departmental view page
        When I follow "Deleted KPIs"
        Then I should be on the deleted kpis page
        And I should see "Deleted Departmental KPIs"
        And I should see "Action"
        When I follow "Restore"

    Scenario: View Departmental SDBIP details
        Given I am on the introduction page
        And I should see "SDBIP"
        When I follow "SDBIP"
        Then I should be on the departmental view page
        Given I am on the departmental view page
        And I should see "Who"
        And I should see "What"
        When I follow "Access to clean running water"
        Then I should be on the view kpi details page
        And I should see "Access to clean running water Details"

    Scenario: Edit Departmental SDBIPs
        Given I am on the introduction page
        And I should see "SDBIP"
        When I follow "SDBIP"
        Then I should be on the departmental view page
        Given I am on the departmental view page
        And I should see "Who"
        And I should see "What"
        When I follow "Edit KPIs"
        Then I should be on the edit kpi page
        And I should see "Who"
        And I should see "What"
        And I should see "Access to clean running water Details"
        And I follow "Access to clean running water Details"
        Then I should be on the edit kpi details page
        When I fill in "" with ""
        And I press "Save"
        Then I should see "KPI was successfully saved."

    Scenario: Update Departmental SDBIPs
        Given I am on the introduction page
        And I should see "SDBIP"
        When I follow "SDBIP"
        Then I should be on the departmental view page
        Given I am on the departmental view page
        And I should see "Who"
        And I should see "What"
        When I follow "Update KPIs"
        Then I should be on the update kpi page
        And I should see "Who"
        And I should see "What"
        And I should see "Access to clean running water Details"
        And I follow "Access to clean running water Details"
        Then I should be on the update kpi details page
        When I fill in "" with ""
        And I press "Save"
        Then I should see "KPI was successfully saved."

    Scenario: Delete Departmental SDBIPs

    Scenario: Search/Filter Departmental SDBIPs

    Scenario: Add Top Layer SDBIPs

    Scenario: Import Top Layer SDBIPs

    Scenario: Browse Top Layer SDBIPs

    Scenario: View Top Layer SDBIP details

    Scenario: Edit Top Layer SDBIPs

    Scenario: Update Top Layer SDBIPs

    Scenario: Delete Top Layer SDBIPs

    Scenario: Add Capital Projects

    Scenario: Import Capital Projects

    Scenario: Browse Capital Projects

    Scenario: View Capital Projects details

    Scenario: Edit Capital Projects

    Scenario: Update Capital Projects

    Scenario: Delete Capital Projects

    Scenario: Browse Monthly Cashflows

    Scenario: View Monthly Cashflows details

    Scenario: Edit Monthly Cashflows

    Scenario: Update Monthly Cashflows

    Scenario: Delete Monthly Cashflows

    Scenario: Browse Revenue by Source

    Scenario: View Revenue by Source details

    Scenario: Edit Revenue by Source

    Scenario: Update Revenue by Source

    Scenario: Delete Revenue by Source
