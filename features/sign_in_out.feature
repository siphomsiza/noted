Feature: Login Functionality Feature

    Scenario: Successful login
        Given I go to login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page

    Scenario: Unsuccessful login
        Given I go to login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "adsdsadsds"
        And I press "Log in"
        Then I should see "wrong log on information provided..."
