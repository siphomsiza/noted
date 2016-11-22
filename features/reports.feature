Feature: Reporting Module(s)

    Background: Log in Successfully As an Admin
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."

    Scenario: Generate Departmental SDBIPs Reports
        Given I am on the introduction page
        And I should see "REPORTS"
        When I follow "REPORTS"
        Then I should be on the departmental sdbips generate report page
        Given I am on the departmental sdbips generate report page
        And I should see "Select the information to be displayed in the report:"
        And I should see "Select the filter you wish to apply:"
        And I should see "Choose your group and sort options:"
        And I should see "Generate the report:"

    Scenario: Generate Departmental SDBIPs Graphs
        Given I am on the introduction page
        And I should see "REPORTS"
        When I follow "REPORTS"
        Then I should be on the departmental sdbips generate report page
        Given I am on the departmental sdbips generate report page
        When I follow "Generate Graphs"
        Then I should be on the generate graphs page
        And I should see "Select the filter you wish to apply:"
        And I should see "Select the layout:"
        And I should see "Generate the report:"
        When I select "Entire Municipality" from "department_id_selection"
        And I follow "Generate"
        Then I should be on the view graph page
        And I should see ""

    Scenario: View Departmental SDBIPs YTD graphs
        Given I am on the introduction page
        And I should see "REPORTS"
        When I follow "REPORTS"
        Then I should be on the departmental sdbips generate report page
        Given I am on the departmental sdbips generate report page
        When I follow "YTD Dashboard"
        Then I should be on the ytd dashboard page
        And I should see "YTD Dashboard"
        When I press "View"
        Then I should be on the view ytd dashboard page
        And I should see "YTD Graphs For"
        And I should see "Sub-Department"
