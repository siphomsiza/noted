require 'test_helper'

class KpiConceptsControllerTest < ActionController::TestCase
  setup do
    @kpi_concept = kpi_concepts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kpi_concepts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kpi_concept" do
    assert_difference('KpiConcept.count') do
      post :create, kpi_concept: { code: @kpi_concept.code, name: @kpi_concept.name }
    end

    assert_redirected_to kpi_concept_path(assigns(:kpi_concept))
  end

  test "should show kpi_concept" do
    get :show, id: @kpi_concept
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kpi_concept
    assert_response :success
  end

  test "should update kpi_concept" do
    patch :update, id: @kpi_concept, kpi_concept: { code: @kpi_concept.code, name: @kpi_concept.name }
    assert_redirected_to kpi_concept_path(assigns(:kpi_concept))
  end

  test "should destroy kpi_concept" do
    assert_difference('KpiConcept.count', -1) do
      delete :destroy, id: @kpi_concept
    end

    assert_redirected_to kpi_concepts_path
  end
end
