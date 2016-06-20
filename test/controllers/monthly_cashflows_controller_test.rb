require 'test_helper'

class MonthlyCashflowsControllerTest < ActionController::TestCase
  setup do
    @monthly_cashflow = monthly_cashflows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:monthly_cashflows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create monthly_cashflow" do
    assert_difference('MonthlyCashflow.count') do
      post :create, monthly_cashflow: { capital_expenditure: @monthly_cashflow.capital_expenditure, department_id: @monthly_cashflow.department_id, line_item: @monthly_cashflow.line_item, month: @monthly_cashflow.month, mscore_classification_id: @monthly_cashflow.mscore_classification_id, operational_expenditure: @monthly_cashflow.operational_expenditure, revenue: @monthly_cashflow.revenue, subdepartment_id: @monthly_cashflow.subdepartment_id, vote_number: @monthly_cashflow.vote_number }
    end

    assert_redirected_to monthly_cashflow_path(assigns(:monthly_cashflow))
  end

  test "should show monthly_cashflow" do
    get :show, id: @monthly_cashflow
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @monthly_cashflow
    assert_response :success
  end

  test "should update monthly_cashflow" do
    patch :update, id: @monthly_cashflow, monthly_cashflow: { capital_expenditure: @monthly_cashflow.capital_expenditure, department_id: @monthly_cashflow.department_id, line_item: @monthly_cashflow.line_item, month: @monthly_cashflow.month, mscore_classification_id: @monthly_cashflow.mscore_classification_id, operational_expenditure: @monthly_cashflow.operational_expenditure, revenue: @monthly_cashflow.revenue, subdepartment_id: @monthly_cashflow.subdepartment_id, vote_number: @monthly_cashflow.vote_number }
    assert_redirected_to monthly_cashflow_path(assigns(:monthly_cashflow))
  end

  test "should destroy monthly_cashflow" do
    assert_difference('MonthlyCashflow.count', -1) do
      delete :destroy, id: @monthly_cashflow
    end

    assert_redirected_to monthly_cashflows_path
  end
end
