Feature: Lists

    Background: Logged in Successfully as Admin
        Given I am on the login page
        When I fill in "session[email]" with "casey@sableassets.com"
        And I fill in "session[company_code]" with "LPN001"
        And I fill in "session[password]" with "sableassets"
        And I press "Log in"
        Then I should be on the introduction page
        And I should see "Logged in sucessfully..."

    Scenario: Browse Lists
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Areas"
        And I should see "Funding Sources"
        And I should see "MSCOA Classification"
        And I should see "KPAs"
        And I should see "KPI Calculation Types"
        And I should see "KPI Concepts"
        And I should see "KPI Owner Titles"
        And I should see "KPI Target Types"
        And I should see "KPI Types"
        And I should see "National Outcomes"
        And I should see "NDP Objectives"
        And I should see "Pre-determined Objectives"
        And I should see "Provincial Strategic Outcomes"
        And I should see "Reporting Category"
        And I should see "Risk Rating"
        And I should see "Strategic Objectives"
        And I should see "Wards"
        And I should see "Job Titles"

    Scenario: Add Areas
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Create"
        When I follow "Create"
        Then I should be on the create lists page
        And I should see "Area(s)"
        And I should see "Configure"
        When I follow "Configure"
        Then I should be on the create area page
        And I should see "Configure Area"
        When I fill in "area[name]" with "Riversands"
        And I press "Save"
        Then I should be on the lists page
        And I should see "Area was successfully created."

    Scenario: View Areas
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Areas"
        When I follow "Areas"
        Then I should see "All"

    Scenario: Edit Areas
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Areas"
        When I follow "Areas"
        Then I should see "All"
        When I follow "All"
        Then I should be on the edit area page
        When I fill in "area[name]" with "Riversands Incubation Hub"
        And I press "Save"
        Then I should be on the lists page
        And I should see "Area was successfully updated."

    Scenario: Delete Areas
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Areas"
        When I follow "Areas"
        Then I should see "All"
        When I follow "All"
        Then I should be on the edit area page
        And I press "Delete"
        Then I should see "Are you sure to delete this area together with it's wards?" within a dialog
        When I press "OK" within a dialog
        Then I should be on the lists page
        And I should see "Area was successfully deleted."

    Scenario: Add Funding Sources
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Create"
        When I follow "Create"
        Then I should be on the create lists page
        And I should see "Funding Source(s)"
        And I should see "Configure"
        When I follow "Configure"
        Then I should be on the create funding source page
        And I should see "Configure Funding Source"
        When I fill in "area[name]" with "Riversands"
        And I press "Save"
        Then I should be on the lists page
        And I should see "Funding source was successfully created."

    Scenario: View Funding Sources
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Funding Sources"
        When I follow "Funding Sources"
        Then I should see "CRR"

    Scenario: Edit Funding Sources
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Funding Sources"
        When I follow "Funding Sources"
        Then I should see "CRR"
        When I follow "CRR"
        Then I should be on the edit funding source page
        And I should see "Editing CRR"
        When I fill in "funding_source[name]" with "CRR"
        And I press "Save"
        Then I should be on the lists page
        And I should see "Funding source was successfully updated."

    Scenario: Delete Funding Sources
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Funding Sources"
        When I follow "Funding Sources"
        Then I should see "CRR"
        When I follow "CRR"
        Then I should be on the edit funding source page
        And I should see "Delete"
        And I follow "Delete"
        Then I should see "Are you sure?" within a dialog
        When I should press "OK" within a dialog
        Then I should be on the lists page
        And I should see "Funding source was successfully deleted."

    Scenario: Add MSCOA Classifications

    Scenario: View MSCOA Classifications
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "MSCOA Classifications"
        When I follow "MSCOA Classifications"
        Then I should see "Executive and council"

    Scenario: Edit MSCOA Classifications

    Scenario: Delete MSCOA Classifications

    Scenario: Add KPAs

    Scenario: View KPAs
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "KPAs"
        When I follow "KPAs"
        Then I should see "Basic Service Delivery"

    Scenario: Edit KPAs

    Scenario: Delete KPAs

    Scenario: Add KPI Calculation Types

    Scenario: View KPI Calculation Types
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "KPI Calculation Types"
        When I follow "KPI Calculation Types"
        Then I should see "Carry Over"

    Scenario: Edit KPI Calculation Types

    Scenario: Delete KPI Calculation Types

    Scenario: Add KPI Concept Types

    Scenario: View KPI Concept Types
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "KPI Concepts"
        When I follow "KPI Concepts"
        Then I should see "Input"

    Scenario: Edit KPI Concept Types

    Scenario: Delete KPI Concept Types

    Scenario: Add KPI Owner Titles

    Scenario: View KPI Owner Titles
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "KPI Owner Titles"
        When I follow "KPI Owner Titles"
        Then I should see "Budget And Financial Reporting Manager"

    Scenario: Edit KPI Concept Titles

    Scenario: Delete KPI Concept Titles

    Scenario: Add KPI Target Types

    Scenario: View KPI Target Types
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "KPI Target Types"
        When I follow "KPI Target Types"
        Then I should see "Currency"

    Scenario: Edit KPI Target Types

    Scenario: Delete KPI Target Types

    Scenario: Add KPI Types

    Scenario: View KPI Types
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "KPI Types"
        When I follow "KPI Types"
        Then I should see "Strategic"

    Scenario: Edit KPI Types

    Scenario: Delete KPI Types

    Scenario: Add National Outcomes

    Scenario: View National Outcomes
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "National Outcomes"
        When I follow "National Outcomes"
        Then I should see "Improve the quality of basic education"

    Scenario: Edit National Outcomes

    Scenario: Delete National Outcomes

    Scenario: Add NDP Objectives

    Scenario: View NDP Objectives
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "NDP Objectives"
        When I follow "NDP Objectives"
        Then I should see "Economy and Development"

    Scenario: Edit NDP Objectives

    Scenario: Delete NDP Objectives

    Scenario: Add Pre-determined Objectives

    Scenario: View Pre-determined Objectives
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Pre-determined Objectives"
        When I follow "Pre-determined Objectives"
        Then I should see "Unspecified"

    Scenario: Edit Pre-determined Objectives

    Scenario: Delete Pre-determined Objectives

    Scenario: Add Provincial Strategic Outcomes

    Scenario: View Provincial Strategic Outcomes
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Provincial Strategic Outcomes"
        When I follow "Provincial Strategic Outcomes"

    Scenario: Edit Provincial Strategic Outcomes

    Scenario: Delete Provincial Strategic Outcomes

    Scenario: Add Reporting Category

    Scenario: View Reporting Category
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Reporting Category"
        When I follow "Reporting Category"
        And I should see "Unspecified"

    Scenario: Edit Reporting Category

    Scenario: Delete Reporting Category

    Scenario: Add Risk Rating

    Scenario: View Risk Rating
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Risk Rating"
        When I follow "Risk Rating"
        And I should see "High"

    Scenario: Edit Risk Rating

    Scenario: Delete Risk Rating

    Scenario: Add Strategic Objectives

    Scenario: View Strategic Objectives
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Strategic Objectives"
        When I follow "Strategic Objectives"
        And I should see "Development Objcetive 1B: To accelerate provision of services relating to disaster management, safety, fire, emergency, as well as traffic and licensing"

    Scenario: Edit Strategic Objectives

    Scenario: Delete Strategic Objectives

    Scenario: View Wards
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Wards"
        When I follow "Wards"
        And I should see "All"

    Scenario: Add Job Titles

    Scenario: View Job Titles
        Given I am on the introduction page
        And I should see "DASHBOARD"
        And I should see "SETUP"
        And I should see "SDBIP"
        And I should see "REPORTS"
        And I should see "USERS"
        And I should see "ABOUT"
        And I should see "KEYSTONE is an online performance management system that provides Municipalities with a secure web-based platform for the day-to-day management of operational processes and data storage on the cloud."
        And I should see "Timely and accurate, this tool reduces administrative headaches on the stakeholders and ensure that all parties involved are accountable for their actions."
        And I should see "Get Started"
        When I follow "SETUP"
        Then I should be on view master setup page
        And I should see "Lists"
        When I follow "Lists"
        Then I should be on the lists page
        And I should see "Job Titles"
        When I follow "Job Titles"
        And I should see "ICT Manager"

    Scenario: Edit Job Titles

    Scenario: Delete Job Titles
