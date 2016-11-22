Feature: Log in & Log out Feature

    Scenario: Successful login
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."

    Scenario: Unsuccessful login with invalid password and user account not locked or terminated
        Given I am on the login page
        When I fill in "session[email]" with "sandiswa@sableassets.co.za"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "adsdsadsds"
        And I press "Log in"
        Then I should see "wrong log on information provided..."

    Scenario: Unsuccessful login with user account locked
        Given I am on the login page
        When I fill in "session[email]" with "sandiswa@sableassets.co.za"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should see "Account Locked.please contact your system administrator."

    Scenario: Unsuccessful login with user account terminated
        Given I am on the login page
        When I fill in "session[email]" with "sandiswa@sableassets.co.za"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should see "Account terminated.please contact your system administrator."

    Scenario: Unsuccessful login with user account not activated
        Given I am on the login page
        When I fill in "session[email]" with "sandiswa@sableassets.co.za"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should see "Account not activated.Check your email for the activation link."

    Scenario: log out
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."
        Given I am on the introduction page
        Then I should see "Hi"
        When I follow "Hi"
        Then I should see "Account"
        When I follow "Log out"
        Then I should be on login page
        And I should see "Welcome Home"
