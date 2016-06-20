require 'test_helper'

class CapitalProjectsControllerTest < ActionController::TestCase
  setup do
    @capital_project = capital_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:capital_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create capital_project" do
    assert_difference('CapitalProject.count') do
      post :create, capital_project: { ActualCompletionDate: @capital_project.ActualCompletionDate, ActualStartDate: @capital_project.ActualStartDate, April: @capital_project.April, Area: @capital_project.Area, August: @capital_project.August, December: @capital_project.December, Department: @capital_project.Department, February: @capital_project.February, FundingSource: @capital_project.FundingSource, IDPNumber: @capital_project.IDPNumber, January: @capital_project.January, July: @capital_project.July, June: @capital_project.June, March: @capital_project.March, May: @capital_project.May, MscoreClassification: @capital_project.MscoreClassification, MunCPRef: @capital_project.MunCPRef, November: @capital_project.November, October: @capital_project.October, PlannedCompletionDate: @capital_project.PlannedCompletionDate, PlannedStartDate: @capital_project.PlannedStartDate, ProjectDescription: @capital_project.ProjectDescription, ProjectName: @capital_project.ProjectName, September: @capital_project.September, Subdepartment: @capital_project.Subdepartment, VoteNumber: @capital_project.VoteNumber, Ward: @capital_project.Ward }
    end

    assert_redirected_to capital_project_path(assigns(:capital_project))
  end

  test "should show capital_project" do
    get :show, id: @capital_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @capital_project
    assert_response :success
  end

  test "should update capital_project" do
    patch :update, id: @capital_project, capital_project: { ActualCompletionDate: @capital_project.ActualCompletionDate, ActualStartDate: @capital_project.ActualStartDate, April: @capital_project.April, Area: @capital_project.Area, August: @capital_project.August, December: @capital_project.December, Department: @capital_project.Department, February: @capital_project.February, FundingSource: @capital_project.FundingSource, IDPNumber: @capital_project.IDPNumber, January: @capital_project.January, July: @capital_project.July, June: @capital_project.June, March: @capital_project.March, May: @capital_project.May, MscoreClassification: @capital_project.MscoreClassification, MunCPRef: @capital_project.MunCPRef, November: @capital_project.November, October: @capital_project.October, PlannedCompletionDate: @capital_project.PlannedCompletionDate, PlannedStartDate: @capital_project.PlannedStartDate, ProjectDescription: @capital_project.ProjectDescription, ProjectName: @capital_project.ProjectName, September: @capital_project.September, Subdepartment: @capital_project.Subdepartment, VoteNumber: @capital_project.VoteNumber, Ward: @capital_project.Ward }
    assert_redirected_to capital_project_path(assigns(:capital_project))
  end

  test "should destroy capital_project" do
    assert_difference('CapitalProject.count', -1) do
      delete :destroy, id: @capital_project
    end

    assert_redirected_to capital_projects_path
  end
end
