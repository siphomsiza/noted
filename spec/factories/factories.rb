FactoryGirl.define do

factory :user do
#avatar { File.new("#{Rails.root}/public/avatars/original/missing.png") }
firstname "Winnie"
email {Faker::Internet.email}
title "miss"
surname "Mahladisa"
id_number "8806040665087"
birth_date "1988-06-04"
username "winnza"
gender "Female"
race "African"
occupational_category "employee"
disabled false
terminated false
disability_description nil
employee_number "mm02"
employment_date "01-02-2016"
job_title "Manager"
location "RiverSands"
manager false
country_prefix "+27"
landline "076245242"
mobile "08234675"
fax "089127625"
status "New"
login_count "0"
login_attempts "0"
max_login_attempts "3"
last_login nil
current_login_at nil
terminated_at nil
last_login_ip nil
current_login_ip nil
reset_digest nil
active_log nil
reset_sent_at nil
super_admin false
admin true
activation_digest nil
activated true
activated_at nil
remember_digest nil
password_digest nil
department_id "01"
password "foobar"
password_confirmation "foobar"

  end
  #factory :invalid_user, parent: :user do
  #  name nil
  #end
end
FactoryGirl.define do
  factory :department do
    name {Faker::Commerce.department}
    tel_no "1221122"
    fax_no "67699887"
  end
end
FactoryGirl.define do
  factory :capital_project do
    project_name "Sport and Culture"
    subdepartment_id  "1"
    mscore_classification_id  "1"
    mun_cp_ref  "1"
    idp_nummber  "8"
    vote_number  "12"
    departmental_sdbip_id  "1"
    funding_source  "Library Grant"
    planned_start_date  nil
    planned_completion_date  nil
    actual_start_date  nil
    actual_completion_date  nil
    ward_id  "1"
    area_id "1"

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
    department_id  "1"
    department_name  "Financial Services"
    subdepartment_name "Forestry"
    subdepartment_id "1"
    kpi_ref_number  "MM01"
    predetermined_objective_id  "Provision of water"
    kpi_owner_id  "1"
    kpi  "Access to clean running water"
    unit_of_measurement "% of Households accessing water"
    mscore_classification_id  "1"
    idp_ref   "1"
    national_outcome_id  "1"
    strategic_objective_id  "1"
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
    kpa_id  "1"
    kpa_name  nil
    ndp_objective_id  "1"
    capital_project_id  "1"
    kpi_concept_id  "1"
    kpi_type_id  "1"
    impact   nil
    provincial_strategic_outcome_id  "1"
    ward_id  "1"
    area_id  "1"
    past_year_performance  nil
    reporting_category_id  "1"
    top_layer_kpi_ref   nil
    kpi_calculation_type_id  "1"
    start_date  nil
    end_date  nil
  end
end

FactoryGirl.define do
  factory :role do
    user_id  "1"
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

FactoryGirl.define do
  factory :revenue_by_source do
    vote_number "1"
    line_item nil
    july nil
august nil
september nil
october nil
november nil
december nil
january nil
february nil
march nil
april nil
may nil
june nil
end
end

FactoryGirl.define do
  factory :jobtitle do
    title "Admin"
  end
end

FactoryGirl.define do
  factory :sdbip_time_period do
    period nil
    start_date nil
    end_date nil
    departmental_sdbip_id "1"
    end
end

FactoryGirl.define do
  factory :master_setup do

    municipality "Mkhondo"
    province "Gauteng"
end
factory :invalid_master_setup, parent: :master_setup do
  municipality nil
end
end

FactoryGirl.define do
  factory :monthly_cashflow do

    month "july"
    vote_number "1"
    subdepartment_id  "1"
    department_id  "1"
    mscore_classification_id  "1"
    line_item  nil
    operational_expenditure nil
    revenue  nil
    capital_expenditure  nil
  end
end

FactoryGirl.define do
  factory :departmental_administrator do

    department_id "1"
    user_id "1"
    can_create false
    can_update false
    can_approve false
    can_edit false
  end
end

FactoryGirl.define do
  factory :funding_source do
    name "CRR"
end
end
FactoryGirl.define do
  factory :invalid_funding_source, :parent => :funding_source do
    name nil
end
end


FactoryGirl.define do
factory :kpa do
  name {Faker::Name.name}
  code {Faker::Number.between(1,100)}
end
end
FactoryGirl.define do
factory :invalid_kpa, parent: :kpa do
  name ''
  code ''
end
end
FactoryGirl.define do
  factory :kpi_calculation_type do

    name "Percentage"
    code "%"
    description "% of applications processed within 60 days"
end
end

FactoryGirl.define do
  factory :kpi_concept do
    name "ABC cable install"
    code "3"
    end
end

FactoryGirl.define do
  factory :kpi_target_type do

    name "currency"
    code "R"
    end
end

FactoryGirl.define do
  factory :kpi_type do

    name "Number"
    code "#"
end
end

FactoryGirl.define do
  factory :kpi_owner do

    user_id "1"
    name  "Municipal Manager"
    can_update false
    end
end


FactoryGirl.define do
  factory :mscore_classification do

    name "Waste Management"
    end
end


FactoryGirl.define do
  factory :mtas_indicator do

name "% of projects completed on time and meeting specifications(quality assessment)"
    end
end

FactoryGirl.define do
  factory :national_outcome do

    name "A development-orientated public service and inclusive citizenship"
  end
end

FactoryGirl.define do
  factory :ndp_objective do

    name "Unspecified"
    end
end

FactoryGirl.define do
  factory :predetermined_objective do
    name "(ABC) install"
    end
end

FactoryGirl.define do
  factory :provincial_strategic_outcome do

    name "A skilled and capable workforce to support inclusive growth"
end
end

FactoryGirl.define do
  factory :reporting_category do

    name "1"
    end
end

FactoryGirl.define do
  factory :risk_rating do

    name "High"
    code "H"
    end
end

FactoryGirl.define do
  factory :strategic_objective do

    name "Develop and build skilled and knowledgeable workforce"
    end
end

FactoryGirl.define do
  factory :subdepartmental_administrator do

    subdepartment_id "0"
    user_id "0"
    can_create false
    can_update false
    can_approve false
    can_edit false
    end
end

FactoryGirl.define do
  factory :top_layer_administrator do

    department_id "1"
    user_id "1"
    can_create false
    can_update false
    can_approve false
    can_edit false
    end
end

FactoryGirl.define do
  factory :sdbip_report do

    sdbip_time_period_id 1
    percentage_actual nil
    financial_actual nil
    performance_comments nil
    corrective_measure nil
    proof_of_evidence "Billing Report"
    past_year_performance nil
    performance_standard nil
end
end
