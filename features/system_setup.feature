Feature: Setup Management

    Background: Log in Successfully As an Admin
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."

    Scenario: View Master Setup
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Ref"
        And I should see "Municipality"
        And I should see "Province"
        And I should see "Location(Lat,Long)"
        And I should see "Regions/Areas"
        And I should see "Actions"

    Scenario: Edit Master Setup
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Ref"
        And I should see "Municipality"
        And I should see "Province"
        And I should see "Location(Lat,Long)"
        And I should see "Regions/Areas"
        And I should see "Actions"
        When I follow "Edit"
        Then I should be on the edit master setup page
        When I press "Save"
        Then I should be on view master setup page
        And should see "Master setup was successfully saved."

    Scenario: Successfully Setup System
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "System Setup"
        Then I should be on the system setup page
        When I follow "Create"
        Then I should be on the create setup page
        When I check "setup[name]"
        And I press "Save"
        Then I should see "Setup saved successfully."
        And should be on the system setup page

    Scenario: Successfully Setup Departments
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Departments"
        Then I should be on Department Setup page
        When I follow "Create"
        Then I should be on the create department page
        When I fill in "department[name]" with "My new Department"
        And I fill in "department[tel_no]" with "0764338939"
        And I fill in "department[fax_no]" with "0833128067"
        And I press "Save"
        Then I should see "Department record was not created."
        And should be on Department Setup page

    Scenario: Successfully Setup Departments with Sub-departments
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Departments"
        Then I should be on Department Setup page
        When I follow "Create"
        Then I should be on the create department page
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
        Then I should be on view master setup page
        When I follow "Departments"
        Then I should be on Department Setup page
        When I follow "Create"
        Then I should be on the create department page
        When I fill in "department[name]" with ""
        And I fill in "department[tel_no]" with ""
        And I fill in "department[fax_no]" with ""
        And I press "Save"
        Then I should see "Department record was not created."
        And should be on Department Setup page

    Scenario: Unsuccessful Department Setup with Sub-departments
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Departments"
        Then I should be on Department Setup page
        When I follow "Create"
        Then I should be on the create department page
        When I fill in "department[name]" with ""
        And I fill in "department[tel_no]" with ""
        And I fill in "department[fax_no]" with ""
        Then I follow "Add Subdepartment"
        And I fill in "subdepartment[name]" with ""
        And I press "Save"
        Then I should see "Department record was not created."
        And should be on Department Setup page

    Scenario: View Departmental Administrators
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Administrators"
        Then I should be on the toplayer administrators setup page
        When I follow "Departmental Administrators"
        Then I should be on the departmental administrators page
        And should see "Department"
        And should see "Administrators"

    Scenario: Successful Departmental Administrators Setup
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Administrators"
        Then I should be on the toplayer administrators setup page
        When I follow "Departmental Administrators"
        Then I should be on the departmental administrators page
        When I follow "Create"
        Then I should be on the create departmental administrators page
        When I select "1" from "departmental_administrator[department_id]"
        And I select "6" from "departmental_administrator[user_id]"
        And I check "departmental_administrator[can_update]"
        And I press "Save"
        Then I should see "Departmental administrator was successfully created."
        And should be on the toplayer administrators setup page

    Scenario: Unsuccessful Departmental Administrators Setup
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Administrators"
        Then I should be on the toplayer administrators setup page
        When I follow "Departmental Administrators"
        Then I should be on the departmental administrators page
        When I follow "Create"
        Then I should be on the create departmental administrators page
        When I select "1" from "departmental_administrator[department_id]"
        And I select "" from "departmental_administrator[user_id]"
        And I check "departmental_administrator[can_update]"
        And I press "Save"
        Then I should see "Departmental administrator was not created."
        And should be on the toplayer administrators setup page

    Scenario: View Subdepartmental Administrators
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Administrators"
        Then I should be on the toplayer administrators setup page
        When I follow "Subdepartmental Administrators"
        Then I should be on the subdepartmental administrators page
        And I should see "Sub-Department"
        And I should see "Administrators"
        And I should see "Actions"

    Scenario: Successful Subdepartmental Administrators Setup
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Administrators"
        Then I should be on the toplayer administrators setup page
        When I follow "Subdepartmental Administrators"
        Then I should be on the subdepartmental administrators page
        When I follow "Create"
        Then I should be on the create subdepartmental administrators page
        When I select "1" from "subdepartmental_administrator[subdepartment_id]"
        And I select "6" from "subdepartmental_administrator[user_id]"
        And I check "departmental_administrator[can_update]"
        And I press "Save"
        Then I should see "Subdepartmental administrator was successfully created."
        And should be on the toplayer administrators setup page

    Scenario: Unsuccessful Subdepartmental Administrators Setup
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Administrators"
        Then I should be on the toplayer administrators setup page
        When I follow "Subdepartmental Administrators"
        Then I should be on the subdepartmental administrators page
        When I follow "Create"
        Then I should be on the create subdepartmental administrators page
        When I select "1" from "subdepartmental_administrator[subdepartment_id]"
        And I select "" from "subdepartmental_administrator[user_id]"
        And I check "departmental_administrator[can_update]"
        And I press "Save"
        Then I should see "Subdepartmental administrator was not created."
        And should be on the toplayer administrators setup page

    Scenario: View KPI Owners
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Administrators"
        Then I should be on the toplayer administrators setup page
        When I follow "KPI Owners"
        Then I should be on kpi owners page
        And I should see "KPI Owner"
        And I should see "Administrators"
        And I should see "Action"

    Scenario: Successful KPI Owners Setup
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Administrators"
        Then I should be on the toplayer administrators setup page
        When I follow "KPI Owners"
        Then I should be on kpi owners page
        And I should see "KPI Owner"
        And I should see "Administrators"
        And I should see "Action"
        When I follow "Add"
        Then I should be on the create kpi owner page
        When I select "Budget and Financial Reporting Manager" from "kpi_owner[name]"
        And I select "6" from "kpi_owner[user_id]"
        And I check "kpi_owner[can_update]"
        And I press "Save"
        Then I should see "Kpi Owner was successfully created."
        And should be on the toplayer administrators setup page

    Scenario: Unsuccessful KPI Owners Setup
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Administrators"
        Then I should be on the toplayer administrators setup page
        When I follow "KPI Owners"
        Then I should be on kpi owners page
        And I should see "KPI Owner"
        And I should see "Administrators"
        And I should see "Action"
        When I follow "Add"
        Then I should be on the create kpi owner page
        When I select "Budget and Financial Reporting Manager" from "kpi_owner[name]"
        And I select "" from "kpi_owner[user_id]"
        And I check "kpi_owner[can_update]"
        And I press "Save"
        Then I should see "KPI Owner not created."
        And should be on the toplayer administrators setup page

    Scenario: View General Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Create"
        When I follow "Create"
        Then I should be on the create heading page
        And I should see "New Heading"
        When I fill in "heading[term]" with "Directoral"
        And I fill in "heading[description]" with "Departmental"
        And I press "Save"
        Then I should be on the view general headings page
        And I should see "Heading was successfully created."

    Scenario: View General Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"

    Scenario: Edit General Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Edit"
        Then I should be on the edit general heading page
        When I fill in "heading[description]" with "New description"
        And I press "Save"
        Then I should be on the view general headings page
        And I should see "Heading was successfully updated."

    Scenario: Delete General Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Delete"
        Then I should see "Are you?"
        When I press "OK"
        Then I should be on the view general headings page
        And I should see "Heading was successfully deleted."

    Scenario: View Departmental Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Departmental SDBIP"
        When I follow "Departmental SDBIP"
        Then I should be on the departmental headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"

    Scenario: Edit Departmental Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Departmental SDBIP"
        When I follow "Departmental SDBIP"
        Then I should be on the departmental headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Edit"
        Then I should be on the edit general heading page
        When I fill in "heading[description]" with "New description"
        And I press "Save"
        Then I should be on the view general headings page
        And I should see "Heading was successfully updated."

    Scenario: Delete Departmental Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Departmental SDBIP"
        When I follow "Departmental SDBIP"
        Then I should be on the departmental headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Delete"
        Then I should see "Are you?"
        When I press "OK"
        Then I should be on the view general headings page
        And I should see "Heading was successfully deleted."

    Scenario: View Top Layer Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Top Layer SDBIP"
        When I follow "Top Layer SDBIP"
        Then I should be on the toplayer headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"

    Scenario: Edit Top Layer Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Top Layer SDBIP"
        When I follow "Top Layer SDBIP"
        Then I should be on the toplayer headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Edit"
        Then I should be on the edit general heading page
        When I fill in "heading[description]" with "New description"
        And I press "Save"
        Then I should be on the view general headings page
        And I should see "Heading was successfully updated."

    Scenario: Delete Top Layer Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Top Layer SDBIP"
        When I follow "Top Layer SDBIP"
        Then I should be on the toplayer headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Delete"
        Then I should see "Are you?"
        When I press "OK"
        Then I should be on the view general headings page
        And I should see "Heading was successfully deleted."

    Scenario: View Capital Projects
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Capital Projects"
        When I follow "Capital Projects"
        Then I should be on the capital projects headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"

    Scenario: Edit Capital Projects Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Capital Projects"
        When I follow "Capital Projects"
        Then I should be on the capital projects headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Edit"
        Then I should be on the edit general heading page
        When I fill in "heading[description]" with "New description"
        And I press "Save"
        Then I should be on the view general headings page
        And I should see "Heading was successfully updated."

    Scenario: Delete Capital Projects Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Capital Projects"
        When I follow "Capital Projects"
        Then I should be on the capital projects headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Delete"
        Then I should see "Are you?"
        When I press "OK"
        Then I should be on the view general headings page
        And I should see "Heading was successfully deleted."

    Scenario: View Monthly Cashflows
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Monthly Cashflows"
        When I follow "Monthly Cashflows"
        Then I should be on the monthly cashflows headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"

    Scenario: Edit Monthly Cashflows Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Monthly Cashflows"
        When I follow "Monthly Cashflows"
        Then I should be on the monthly cashflows headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Edit"
        Then I should be on the edit general heading page
        When I fill in "heading[description]" with "New description"
        And I press "Save"
        Then I should be on the view general headings page
        And I should see "Heading was successfully updated."

    Scenario: Delete Monthly Cashflows Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Monthly Cashflows"
        When I follow "Monthly Cashflows"
        Then I should be on the monthly cashflows headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Delete"
        Then I should see "Are you?"
        When I press "OK"
        Then I should be on the view general headings page
        And I should see "Heading was successfully deleted."

    Scenario: View Revenue by Source
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Revenue by Source"
        When I follow "Revenue by Source"
        Then I should be on the revenue by source headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"

    Scenario: Edit Revenue by Source Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Revenue by Source"
        When I follow "Revenue by Source"
        Then I should be on the revenue by source headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Edit"
        Then I should be on the edit general heading page
        When I fill in "heading[description]" with "New description"
        And I press "Save"
        Then I should be on the view general headings page
        And I should see "Heading was successfully updated."

    Scenario: Delete Revenue by Source Headings
        Given I am on the introduction page
        When I follow "SETUP"
        Then I should be on view master setup page
        When I follow "Headings"
        Then I should be on the view general headings page
        And I should see "Revenue by Source"
        When I follow "Revenue by Source"
        Then I should be on the revenue by source headings page
        And I should see "Default Terminology"
        And I should see "Client Terminology"
        When I follow "Delete"
        Then I should see "Are you?"
        When I press "OK"
        Then I should be on the view general headings page
        And I should see "Heading was successfully deleted."
