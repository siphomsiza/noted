Feature: About

    Scenario: Logged in Successfully as a user
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."
        Given I am on the introduction page
        Then I should see "ABOUT"
        When I follow "ABOUT"
        Then I should be on the about page
        And I should see "DASHBOARD"
        And I should see "Overall Municipal SDBIP management summary by Users Statistics, Total Performance Standards, Total Performance Standards by Department, SDBIP Time Periods, Activity Log."
        And I should see "SETUP"
        And I should see "KEYSTONE Application Setup, Department Setup, Lists Setup, Roles Setup, Headings Setup and Time Periods Setup."
        And I should see "SDBIP"
        And I should see "View, Manage (Edit/Create/Delete) Departmental SDBIP, Capital Projects, Monthly Cashflows, Revenue by Source."
        And I should see "REPORTS"
        And I should see "Generate customized Departmental SDBIP, Capital Projects, Monthly Cashflows, Revenue by Source reports and graphs."
        And I should see "USERS"
        And I should see "Manage (Create/Update/View/Delete) Users, Roles and KEYSTONE Access Rights."
        And I should see "ABOUT"
        And I should see "Overall summary of the features supported by the KEYSTONE Application."

    Scenario: Logged in Successfully as a user
        Given I am on the login page
        When I fill in "session[email]" with "sandiswa@sableassets.co.za"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "zsdfdfdfd"
        And I press "Log in"
        Then I should be on the login page
        And I should see "wrong log on information provided..."
        And I should not see "ABOUT"
        And I should not see "DASHBOARD"
        And I should not see "Overall Municipal SDBIP management summary by Users Statistics, Total Performance Standards, Total Performance Standards by Department, SDBIP Time Periods, Activity Log."
        And I should not see "SETUP"
        And I should not see "KEYSTONE Application Setup, Department Setup, Lists Setup, Roles Setup, Headings Setup and Time Periods Setup."
        And I should not see "SDBIP"
        And I should not see "View, Manage (Edit/Create/Delete) Departmental SDBIP, Capital Projects, Monthly Cashflows, Revenue by Source."
        And I should not see "REPORTS"
        And I should not see "Generate customized Departmental SDBIP, Capital Projects, Monthly Cashflows, Revenue by Source reports and graphs."
        And I should not see "USERS"
        And I should not see "Manage (Create/Update/View/Delete) Users, Roles and KEYSTONE Access Rights."
        And I should not see "ABOUT"
        And I should not see "Overall summary of the features supported by the KEYSTONE Application."
