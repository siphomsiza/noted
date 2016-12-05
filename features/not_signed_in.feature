Feature: Operate the system without logging in

    Scenario: Given I have not logged in
        Given I am on the login page
        When I go to the dashboard page
        Then I should be on the login page
        And I should see "Please log in."
