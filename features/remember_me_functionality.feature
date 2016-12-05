Feature: Remember Me on Log in

    Scenario: Log in Successfully As an Admin
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I check "session[remember_me]"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."
