
FactoryGirl.define do
  factory :top_layer_sdbip do
  
    department_id  { Faker::Number.number(2) }
    reporting_kpi  false
    idp_ref  02
    mscore_classification_id  { Faker::Number.number(5) }
    national_outcome_id  { Faker::Number.number(6) }
    kpa_id   { Faker::Number.number(16) }
    predetermined_objective_id  { Faker::Number.number(7) }
    ndp_objective_id  { Faker::Number.number(8) }
    strategic_objective_id  { Faker::Number.number(9) }
    kpi  "Access to clean running water"
    unit_of_measurement  "% of Households accessing water"
    risk  nil
    ward_id  { Faker::Number.number(10) }
    area_id  { Faker::Number.number(11) }
    kpi_owner_id  { Faker::Number.number(12) }
    baseline  nil
    poe  nil
    past_year_performance  nil
    mtas_indicator_id  { Faker::Number.number(13) }
    reporting_category  nil
    kpi_calculation_type_id  { Faker::Number.number(14) }
    kpi_target_type_id  { Faker::Number.number(15) }
    annual_target  nil
    revised_target  nil
    first_quarter_target  nil
    second_quarter_target  nil
    third_quarter_target  nil
    fourth_quarter_target  nil
    first_quarter_actual  nil
    second_quarter_actual  nil
    third_quarter_actual  nil
    fourth_quarter_actual  nil
  end

end