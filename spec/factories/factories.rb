FactoryGirl.define do
  factory :user do

  trait :agent do
      role "agent"
    end
    
    firstname  "Winnie"
    email   "m.winnza@gmail.com"
    title  "miss"
    surname "Mahladisa"
    gender  "Female"
    race  "African"
    occupational_category  "Employee"
    disabled  false
    terminated     false
    disability_description nil
    employee_number  nil
    employment_date "04/06/2016"
    job_title   nil
    location    nil
    manager     nil
    country_prefix  nil
    landline  "015 234 5678"
    mobile    "083 234 5678"
    fax       "086 789 1234"
    status    "New"
    login_count  "1"
    login_attempts   "0"
    max_login_attempts   "3"
    last_login  nil
    current_login_at nil
    terminated_at  nil
    last_login_ip    nil
    current_login_ip  nil
    reset_digest   nil
    active_log  nil
    reset_sent_at   nil
    admin         true
    support          false
    standard_user    false
    assurance        false
    activation_digest  nil
    activated         true
    activated_at    "04/07/2016"
    remember_digest  true
    password_digest   true
    department_id   "2"
    created_at       false
    updated_at      false
    password "foobar"
    password_confirmation "foobar"
  end
  #factory :invalid_user, parent: :user do
  #  name nil
  #end
end
FactoryGirl.define do
  factory :department do
    name "Technical Services"
    tel_no "1221122"
    fax_no "67699887"
  end
end
FactoryGirl.define do
  factory :capital_project do
    project_name "Technical Services"
    department_id  nil
    subdepartment_id  nil
    mscore_classification_id  nil
    mun_cp_ref  nil
    idp_nummber  nil
    vote_number  nil
    project_description  "mm20"
    funding_source  nil
    planned_start_date  nil
    planned_completion_date  nil
    actual_start_date  nil
    actual_completion_date  nil
    ward_id  nil
    area_id nil
    july  nil
    august  nil
    september  nil
    october  nil
    november  nil
    december  nil
    january  nil
    february  nil
    march  nil
    april  nil
    may  nil
    june  nil

  end
end
FactoryGirl.define do
  factory :heading do
    term "project name"
    description "project name"
    category "capital projects"
  end
end
FactoryGirl.define do
  factory :departmental_sdbip do
    department_id  01
    department_name  "Fanancial Services"
    subdepartment_name "Municipal Manager"
    subdepartment_id 01
    kpi_ref_number  "MM01"
    predetermined_objective_id  "Provision of water"
    kpi_owner_id  01
    kpi  "Access to clean running water"
    unit_of_measurement "% of Households accessing water"
    mscore_classification_id  01
    idp_ref   01
    national_outcome_id  01
    strategic_objective_id  01
    source_of_evidence   "Billing Report"
    baseline  nil
    budget  nil
    annual_target  nil
    revised_target  nil
    first_quarter_target  nil
    second_quarter_target  nil
    third_quarter_target  nil
    fourth_quarter_target  nil
    performance_comments  nil
    corrective_measures  nil
    first_quarter_actual  nil
    second_quarter_actual  nil
    third_quarter_actual   nil
    fourth_quarter_actual  nil
    first_quarter_poe  nil
    second_quarter_poe  nil
    third_quarter_poe  nil
    fourth_quarter_poe  nil
    performance_standard  nil
    risk_rating_id  nil
    kpa_id  nil
    kpa_name  nil
    ndp_objective_id  nil
    capital_project_id  nil
    kpi_concept_id  nil
    kpi_type_id  nil
    impact   nil
    provincial_strategic_outcome_id  nil
    ward_id  nil
    area_id  nil
    past_year_performance  nil
    reporting_category_id  nil
    top_layer_kpi_ref   nil
    kpi_calculation_type_id  nil
    start_date  nil
    end_date  nil
  end
end

FactoryGirl.define do
  factory :role do
    user_id  01
    kpi_owner_id   01
    kpi_owner  false
    finance_admin  false
    municipal_manager  true
    subdepartmental_administrator false
    departmental_administrator  false
    internal_auditor  false
    auditor_general  false

  end
end

FactoryGirl.define do
  factory :list do
    name "first name"
    description "text"
end
end
