Feature: User Management Module(s)

    Background: Log in Successfully As an Admin
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."

    Scenario: View Active Users
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        And I should see "Avatar"
        And I should see "Ref"
        And I should see "First Name"
        And I should see "Last Name"
        And I should see "Email"
        And I should see "Date Added"
        And I should see "Last Login"

    Scenario: Edit/Update Active User details
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Active"
        Then I should be on the active users page
        And I should see "Actions"
        When I follow "Edit Details"
        Then I should be on the edit active user page
        When I select "Mr." from "user[title]"
        And I press "Save"
        Then I should see "User details updated successfully"
        And I should be on the active users page

    Scenario: Lock Active User
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Active"
        Then I should be on the active users page
        And I should see "Actions"
        When I follow "Edit Details"
        Then I should be on the edit active user page
        When I follow "Lock"
        Then I should see "User account locked successfully"
        And I should be on the active users page

    Scenario: Terminate Active User
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Active"
        Then I should be on the active users page
        And I should see "Actions"
        When I follow "Edit Details"
        Then I should be on the edit active user page
        When I follow "Terminate"
        Then I should see "Account terminated successfully"
        And I should be on the active users page

    Scenario: View locked User
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Locked"
        Then I should be on the locked users page
        And I should see "Unlock User"

    Scenario: Unlock User
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Locked"
        Then I should be on the locked users page
        And I should see "Unlock User"
        When I follow "Unlock User"
        Then I should be on the edit active user page
        When I follow "Terminate"
        Then I should see "Unlock user's account?"
        When I press "ok"
        Then I should see "Unlocked user's account successfully."
        And I should be on the active users page

    Scenario: View Terminated users
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Terminated"
        Then I should be on the terminated users page
        And I should see "Restore"

    Scenario: Restore Terminated users
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Terminated"
        Then I should be on the terminated users page
        And I should see "Restore"
        When I follow "Restore"
        Then I should see "restore user's account?"
        When I press "ok"
        Then I should see "user's account restored successfully."
        And I should be on the active users page

    Scenario: View All Users
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "All"
        Then I should be on the all users page
        And I should see "Avatar"
        And I should see "Ref"
        And I should see "First Name"
        And I should see "Last Name"
        And I should see "Date Added"
        And I should see "Last Login"
        And I should see "Status"
        And I should see "Date Terminated"
        And I should see "Actions"

    Scenario: Edit User details
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "All"
        Then I should be on the all users page
        And I should see "Actions"
        When I follow "Edit Details"
        Then I should be on the edit user details page
        When I fill in "user[birth_date]" with "1988/02/29"
        And I press "Save"
        Then I should see "User details updated successfully"
        And I should be on the active users page

    Scenario: Edit User Access
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "All"
        Then I should be on the all users page
        And I should see "Actions"
        When I follow "Edit Access"
        Then I should be on the edit user access page
        When I check "role[kpi_owner]"
        And I press "Save"
        Then I should see "Role was successfully saved"
        And I should be on the active users page

    Scenario: Edit User Access
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "All"
        Then I should be on the all users page
        And I should see "Actions"
        When I follow "Reset Password"
        Then I should be on the reset password page
        When I fill in "password_reset[email]" with "casey@sableassets.com"
        And I press "Submit"
        Then I should see "Email sent with password reset instructions"
        And I should be on the active users page

    Scenario: Delete User
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "All"
        Then I should be on the all users page
        And I should see "Actions"
        When I follow "Delete"
        Then I should see "Are you sure?" within a dialog
        When I press "OK" within a dialog
        Then I should see "User deleted"
        And I should be on the active users page

    Scenario: Lock User
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "All"
        Then I should be on the all users page
        And I should see "Actions"
        When I follow "Edit Details"
        Then I should be on the edit active user page
        When I follow "Lock"
        Then I should see "User account locked successfully"
        And I should be on the active users page

    Scenario: Terminate User
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "All"
        Then I should be on the all users page
        And I should see "Actions"
        When I follow "Edit Details"
        Then I should be on the edit active user page
        When I follow "Terminate"
        Then I should see "Account terminated successfully"
        And I should be on the active users page

    Scenario: View User details
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Report Users"
        Then I should be on the report users page
        And I should see "User Details"
        And should see "Avatar"

    Scenario: View User details Log
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Report Users"
        Then I should be on the report users page
        And I should see "Users Details Log"
        When I follow "Users Details Log"
        Then I should be on the user details log page
        And should see "Avatar"

    Scenario: View Login Attempts log
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Report Users"
        Then I should be on the report users page
        And I should see "Login Attempts Log"
        When I follow "Login Attempts Log"
        Then I should be on the login attempts log page
        And should see "Avatar"

    Scenario: View Super User Activity log
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Report Users"
        Then I should be on the report users page
        And I should see "Super User Activity Log"
        When I follow "Super User Activity Log"
        Then I should be on the super user activity log page
        And should see "Avatar"

    Scenario: View User Activity log
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Report Users"
        Then I should be on the report users page
        And I should see "User Activity Log"
        When I follow "User Activity Log"
        Then I should be on the user activity log page
        And should see "Avatar"

    Scenario: Setup User Access
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Setup Users"
        Then I should be on the setup users page
        And I should see "User Access"
        When I follow "User Access"
        Then I should be on the user access page
        And should see "User"
        And should see "System Admin"
        And should see "KPI Admin"
        And should see "Finance Admin"
        And should see "Top Layer Admin"
        And should see "Audit Log Reporting"
        And should see "Assurance Provider"
        And should see "Secondary Time Period"
        And should see "Setup"
        And should see "Action"

    Scenario: Setup User Access
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Setup Users"
        Then I should be on the setup users page
        And I should see "User Access"
        When I follow "User Access"
        Then I should be on the user access page
        And should see "User"
        And should see "System Admin"
        And should see "KPI Admin"
        And should see "Finance Admin"
        And should see "Top Layer Admin"
        And should see "Audit Log Reporting"
        And should see "Assurance Provider"
        And should see "Secondary Time Period"
        And should see "Setup"
        And should see "Action"
        When I follow "Edit Access"
        Then I should be on edit user access page
        When I check "role[kpi_owner]"
        And I press "Save"
        Then I should see "Role was successfully saved"
        And I should be on the user access page

    Scenario: Remove Admin Users
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Setup Users"
        Then I should be on the setup users page
        And I should see "Admin Users"
        When I follow "Admin Users"
        Then I should be on the admin user page
        And should see "Avatar"
        And should see "Ref"
        And should see "First Name"
        And should see "Last Name"
        And should see "Email"
        And should see "Admin Status"
        And should see "Action"
        When I follow "Remove user as Administrator"
        Then I should see "User removed as System Administrator successfully."
        And I should be on the setup users page

    Scenario: Set Admin Users
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Setup Users"
        Then I should be on the setup users page
        And I should see "Admin Users"
        When I follow "Admin Users"
        Then I should be on the admin user page
        And should see "Avatar"
        And should see "Ref"
        And should see "First Name"
        And should see "Last Name"
        And should see "Email"
        And should see "Admin Status"
        And should see "Action"
        When I follow "Add as Administrator"
        Then I should see "User set as System Administrator."
        And I should be on the setup users page

    Scenario: Set Super User
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Setup Users"
        Then I should be on the setup users page
        And I should see "Security Settings"
        When I follow "Security Settings"
        Then I should be on the security setup page
        And should see "Set Super User"
        When I press "Set Super User"
        Then I should be on the set super user page
        When I select "Sandiswa" from "user_id"
        And I press "Save"
        Then I should see "User set to super user/admin successfully."
        And I should be on the setup users page

    Scenario: Add User to System with valid Information
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Add User"
        Then I should be on the add user page
        And I should see "New User"
        When I select "Mr." from "user[title]"
        And I fill in "user[firstname]" with "Security Settings"
        And I fill in "user[surname]" with "Sable"
        And I fill in "user[birth_date]" with "1988/02/29"
        And I fill in "user[id_number]" with "1234567890123"
        And I fill in "user[username]" with "sssable"
        And I fill in "user[password]" with "foobar"
        And I fill in "user[password_confirmation]" with "foobar"
        And I fill in "user[employee_number]" with "MBV232"
        And I fill in "user[employment_date]" with "2015/12/01"
        And I select "Municipal Manager's Office" from "user[department_id]"
        And I fill in "user[email]" with "neziswa@sableassets.com"
        And I select "Male" from "user[gender]"
        And I press "Save"
        Then I should see "Please check your email to confirm your account."
        And I should be on the add user page

    Scenario: Add User to System with invalid Information
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Add User"
        Then I should be on the add user page
        And I should see "New User"
        When I select "Mr." from "user[title]"
        And I fill in "user[firstname]" with ""
        And I fill in "user[surname]" with ""
        And I fill in "user[birth_date]" with "1988/02/29"
        And I fill in "user[id_number]" with "1234567890123"
        And I fill in "user[username]" with "sssable"
        And I fill in "user[password]" with "foobar"
        And I fill in "user[password_confirmation]" with "foobar"
        And I fill in "user[employee_number]" with "MBV232"
        And I fill in "user[employment_date]" with "2015/12/01"
        And I select "Municipal Manager's Office" from "user[department_id]"
        And I fill in "user[email]" with "neziswa@sableassets.com"
        And I select "Male" from "user[gender]"
        And I press "Save"
        Then I should see "Failed to add new user. Please complete properly the fields below."
        And I should be on the add user page

    Scenario: Set Maximum Log in Attempts
        Given I am on the introduction page
        And I should see "USERS"
        When I follow "USERS"
        Then I should be on manage users page
        Given I am on manage users page
        When I follow "Setup Users"
        Then I should be on the setup users page
        And I should see "Security Settings"
        When I follow "Security Settings"
        Then I should be on the security setup page
        And should see "Set Maximum Attempts"
        And should see "Set Super User"
        When I press "Set Maximum Attempts"
        Then I should be on the set maximum login attempts page
        When I fill in "attempts" with 5
        And I press "Submit"
        Then I should see "Maximum login attempts updated successfully."
        And I should be on the setup users page
