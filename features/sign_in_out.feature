Feature: Login Functionality Feature

    Scenario: Successful login
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "DASHBOARD"
        And I should see "INTRODUCTION"
        And I should see "SETUP"

    Scenario: Unsuccessful login
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "adsdsadsds"
        And I press "Log in"
        Then I should see "wrong log on information provided..."

    Scenario: log out
        Given I am on the introduction page
        Then I should see "Hi"
        When I follow "Hi"
        Then I should see "Account"
        When I follow "Log out"
        Then I should be on the login page
        And I should see "Welcome Home"
