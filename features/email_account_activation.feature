Feature: Activate User Account

    Background: Given I am a registered user
        And I have received email confirmation

    Scenario: Successfully Activate User Account and Change User password
        Then I should be on set new password page
        And I should see "Account activated!"
        Given I am on set new password page

    Scenario: Unsuccessfully Activate User Account
        Then I should be on login page
        And I should see "Invalid activation link"
