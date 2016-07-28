# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160725115052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "user_id",               null: false
    t.string   "browser"
    t.string   "ip_address"
    t.string   "params"
    t.integer  "departmental_sdbip_id", null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "activity_logs", force: :cascade do |t|
    t.string   "user_id"
    t.string   "admin",      default: "f"
    t.string   "browser"
    t.string   "ip_address"
    t.string   "controller"
    t.string   "action"
    t.string   "params"
    t.string   "note"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assurances", force: :cascade do |t|
    t.integer  "departmental_sdbip_id", null: false
    t.integer  "user_id"
    t.boolean  "signed_off"
    t.text     "response"
    t.integer  "kpi_result_id",         null: false
    t.binary   "poe"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.integer  "kpi_result_id", null: false
    t.string   "poe"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "capital_projects", force: :cascade do |t|
    t.integer  "subdepartment_id",         null: false
    t.integer  "mscore_classification_id", null: false
    t.integer  "departmental_sdbip_id",    null: false
    t.string   "mun_cp_ref"
    t.string   "idp_nummber"
    t.string   "vote_number"
    t.string   "project_name"
    t.string   "funding_source"
    t.date     "planned_start_date"
    t.date     "planned_completion_date"
    t.date     "actual_start_date"
    t.date     "actual_completion_date"
    t.integer  "ward_id"
    t.integer  "area_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "departmental_administrators", force: :cascade do |t|
    t.integer  "department_id",                 null: false
    t.integer  "user_id",                       null: false
    t.boolean  "can_create",    default: false
    t.boolean  "can_edit",      default: false
    t.boolean  "can_update",    default: false
    t.boolean  "can_approve",   default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "departmental_kpis", force: :cascade do |t|
    t.integer  "department_id",                                                    null: false
    t.string   "department_name",                                                  null: false
    t.string   "subdepartment_name",                                               null: false
    t.integer  "subdepartment_id",                                                 null: false
    t.string   "kpi_ref_number"
    t.integer  "predetermined_objective_id"
    t.integer  "kpi_owner_id"
    t.text     "kpi"
    t.string   "unit_of_measurement"
    t.integer  "mscore_classification_id"
    t.string   "idp_ref"
    t.integer  "national_outcome_id"
    t.integer  "strategic_objective_id"
    t.integer  "kpi_target_type_id"
    t.string   "source_of_evidence"
    t.string   "baseline"
    t.string   "budget"
    t.integer  "annual_target"
    t.integer  "revised_target"
    t.integer  "first_quarter_target"
    t.integer  "second_quarter_target"
    t.integer  "third_quarter_target"
    t.integer  "fourth_quarter_target"
    t.text     "performance_comments"
    t.text     "corrective_measures"
    t.integer  "first_quarter_actual"
    t.integer  "second_quarter_actual"
    t.integer  "third_quarter_actual"
    t.integer  "fourth_quarter_actual"
    t.binary   "first_quarter_poe"
    t.binary   "second_quarter_poe"
    t.binary   "third_quarter_poe"
    t.binary   "fourth_quarter_poe"
    t.string   "performance_standard",            default: "KPI Not Yet Measured", null: false
    t.integer  "risk_rating_id"
    t.integer  "kpa_id"
    t.string   "kpa_name"
    t.integer  "ndp_objective_id"
    t.integer  "kpi_concept_id"
    t.integer  "kpi_type_id"
    t.string   "impact"
    t.integer  "provincial_strategic_outcome_id"
    t.integer  "ward_id"
    t.integer  "area_id"
    t.text     "past_year_performance"
    t.integer  "reporting_category_id"
    t.string   "top_layer_kpi_ref"
    t.integer  "kpi_calculation_type_id"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
  end

  create_table "departmental_sdbips", force: :cascade do |t|
    t.integer  "department_id",                                                    null: false
    t.string   "department_name",                                                  null: false
    t.string   "subdepartment_name",                                               null: false
    t.integer  "subdepartment_id",                                                 null: false
    t.string   "kpi_ref_number"
    t.integer  "predetermined_objective_id"
    t.integer  "kpi_owner_id"
    t.text     "kpi"
    t.string   "unit_of_measurement"
    t.integer  "mscore_classification_id"
    t.string   "idp_ref"
    t.integer  "national_outcome_id"
    t.integer  "strategic_objective_id"
    t.integer  "kpi_target_type_id"
    t.string   "source_of_evidence"
    t.string   "baseline"
    t.string   "budget"
    t.decimal  "annual_target",                   default: 0.0
    t.decimal  "revised_target"
    t.decimal  "first_quarter_target"
    t.decimal  "second_quarter_target"
    t.decimal  "third_quarter_target"
    t.decimal  "fourth_quarter_target"
    t.text     "performance_comments"
    t.text     "corrective_measures"
    t.decimal  "first_quarter_actual"
    t.decimal  "second_quarter_actual"
    t.decimal  "third_quarter_actual"
    t.decimal  "fourth_quarter_actual"
    t.binary   "first_quarter_poe"
    t.binary   "second_quarter_poe"
    t.binary   "third_quarter_poe"
    t.binary   "fourth_quarter_poe"
    t.string   "performance_standard",            default: "KPI Not Yet Measured", null: false
    t.integer  "risk_rating_id"
    t.integer  "kpa_id"
    t.string   "kpa_name"
    t.integer  "ndp_objective_id"
    t.integer  "kpi_concept_id"
    t.integer  "kpi_type_id"
    t.string   "impact"
    t.integer  "provincial_strategic_outcome_id"
    t.integer  "ward_id"
    t.integer  "area_id"
    t.text     "past_year_performance"
    t.integer  "reporting_category_id"
    t.string   "top_layer_kpi_ref"
    t.integer  "kpi_calculation_type_id"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
  end

  add_index "departmental_sdbips", ["kpi_ref_number"], name: "index_departmental_sdbips_on_kpi_ref_number", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "tel_no",     null: false
    t.string   "fax_no",     null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "departments", ["name"], name: "index_departments_on_name", using: :btree

  create_table "funding_sources", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "headings", force: :cascade do |t|
    t.string   "term"
    t.string   "description"
    t.string   "category"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "jobtitles", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kpas", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kpi_calculation_types", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.integer  "list_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "kpi_concepts", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kpi_owners", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                       null: false
    t.boolean  "can_update", default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "kpi_results", force: :cascade do |t|
    t.integer  "departmental_sdbip_id"
    t.integer  "user_id"
    t.decimal  "target"
    t.decimal  "actual"
    t.text     "corrective_measures"
    t.text     "performance_comments"
    t.string   "kpi_performance_standard"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "kpi_target_types", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kpi_types", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "list_setups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "master_setups", force: :cascade do |t|
    t.string   "municipality", null: false
    t.string   "province",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "monthly_cashflows", force: :cascade do |t|
    t.string   "month"
    t.string   "vote_number"
    t.integer  "subdepartment_id",         null: false
    t.integer  "department_id",            null: false
    t.integer  "mscore_classification_id", null: false
    t.string   "line_item"
    t.decimal  "operational_expenditure"
    t.decimal  "revenue"
    t.decimal  "capital_expenditure"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "mscore_classifications", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mtas_indicators", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "municipal_kpas", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "national_kpas", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "national_outcomes", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ndp_objectives", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "predetermined_objectives", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provincial_strategic_outcomes", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "master_setup_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "reporting_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "revenue_by_sources", force: :cascade do |t|
    t.string   "vote_number"
    t.string   "line_item"
    t.string   "july"
    t.string   "august"
    t.string   "september"
    t.string   "october"
    t.string   "november"
    t.string   "december"
    t.string   "january"
    t.string   "february"
    t.string   "march"
    t.string   "april"
    t.string   "may"
    t.string   "june"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "risk_ratings", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id",                                 null: false
    t.boolean  "kpi_owner",               default: false
    t.boolean  "finance_admin",           default: false
    t.boolean  "top_layer_administrator", default: false
    t.boolean  "assurance_provider",      default: false
    t.boolean  "audit_log_reporting",     default: false
    t.boolean  "secondary_time_period",   default: false
    t.boolean  "setup",                   default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "roles_details", force: :cascade do |t|
    t.integer  "role_id",                          null: false
    t.integer  "subdepartment_id",                 null: false
    t.integer  "department_id",                    null: false
    t.boolean  "can_update",       default: false
    t.boolean  "can_edit",         default: false
    t.boolean  "can_create",       default: false
    t.boolean  "can_delete",       default: false
    t.boolean  "do_setup",         default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "sdbip_time_periods", force: :cascade do |t|
    t.date     "period",                             null: false
    t.date     "primary_reminder"
    t.date     "secondary_reminder"
    t.date     "primary_closure"
    t.date     "secondary_closure"
    t.date     "finance_reminder"
    t.date     "finance_closure"
    t.boolean  "primary_status",     default: true
    t.boolean  "secondary_status",   default: true
    t.boolean  "finance_status",     default: true
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "setups", force: :cascade do |t|
    t.boolean  "performance_comments",                   default: false
    t.integer  "performance_length"
    t.boolean  "project_life_cycle",                     default: false
    t.boolean  "include_previous_departmental_actual",   default: false
    t.boolean  "include_departmental_previous_comments", default: false
    t.boolean  "include_departmental_next_target",       default: false
    t.boolean  "include_toplayer_previous_target",       default: false
    t.boolean  "include_toplayer_next_target",           default: false
    t.boolean  "include_toplayer_previous_comments",     default: false
    t.boolean  "attach_poe",                             default: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  create_table "strategic_objectives", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subdepartmental_administrators", force: :cascade do |t|
    t.integer  "subdepartment_id", default: 0
    t.integer  "user_id",          default: 0
    t.boolean  "can_create",       default: false
    t.boolean  "can_edit",         default: false
    t.boolean  "can_update",       default: false
    t.boolean  "can_approve",      default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "subdepartments", force: :cascade do |t|
    t.string   "subdepartment_name", null: false
    t.integer  "department_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "top_layer_administrators", force: :cascade do |t|
    t.integer  "user_id",                       null: false
    t.integer  "department_id",                 null: false
    t.boolean  "can_edit",      default: false
    t.boolean  "can_create",    default: false
    t.boolean  "can_approve",   default: false
    t.boolean  "can_update",    default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "top_layer_sdbips", force: :cascade do |t|
    t.integer  "department_id",                              null: false
    t.boolean  "reporting_kpi",              default: false, null: false
    t.string   "idp_ref"
    t.integer  "mscore_classification_id",                   null: false
    t.integer  "national_outcome_id",                        null: false
    t.integer  "kpa_id",                                     null: false
    t.integer  "predetermined_objective_id",                 null: false
    t.integer  "ndp_objective_id",                           null: false
    t.integer  "strategic_objective_id",                     null: false
    t.text     "kpi"
    t.text     "unit_of_measurement"
    t.text     "risk"
    t.integer  "ward_id",                                    null: false
    t.integer  "area_id",                                    null: false
    t.integer  "kpi_owner_id",                               null: false
    t.string   "baseline"
    t.binary   "poe"
    t.text     "past_year_performance"
    t.integer  "mtas_indicator_id",                          null: false
    t.string   "reporting_category"
    t.integer  "kpi_calculation_type_id",                    null: false
    t.integer  "kpi_target_type_id",                         null: false
    t.decimal  "annual_target"
    t.decimal  "revised_target"
    t.decimal  "first_quarter_target"
    t.decimal  "second_quarter_target"
    t.decimal  "third_quarter_target"
    t.decimal  "fourth_quarter_target"
    t.decimal  "first_quarter_actual"
    t.decimal  "second_quarter_actual"
    t.decimal  "third_quarter_actual"
    t.decimal  "fourth_quarter_actual"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname",                                         null: false
    t.string   "email"
    t.string   "title"
    t.string   "surname"
    t.string   "id_number",              limit: 13,                 null: false
    t.date     "birth_date"
    t.string   "username"
    t.string   "gender"
    t.string   "race"
    t.string   "occupational_category"
    t.boolean  "disabled"
    t.boolean  "terminated",                        default: false
    t.string   "disability_description"
    t.string   "employee_number"
    t.date     "employment_date"
    t.string   "job_title"
    t.string   "location"
    t.string   "manager"
    t.string   "country_prefix"
    t.string   "landline"
    t.string   "mobile"
    t.string   "fax"
    t.string   "status",                            default: "New"
    t.integer  "login_count",                       default: 0
    t.integer  "login_attempts",                    default: 0
    t.integer  "max_login_attempts",                default: 3
    t.datetime "last_login"
    t.datetime "current_login_at"
    t.datetime "terminated_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "reset_digest"
    t.string   "active_log"
    t.datetime "reset_sent_at"
    t.boolean  "super_admin",                       default: false
    t.boolean  "admin",                             default: false
    t.boolean  "support",                           default: false
    t.boolean  "standard_user",                     default: false
    t.boolean  "assurance",                         default: false
    t.string   "activation_digest"
    t.boolean  "activated",                         default: false
    t.datetime "activated_at"
    t.string   "remember_digest"
    t.string   "password_digest"
    t.integer  "department_id"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  create_table "wards", force: :cascade do |t|
    t.string   "name"
    t.integer  "ward_no",    null: false
    t.string   "mun_ref"
    t.integer  "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
