json.array!(@monthly_cashflows) do |monthly_cashflow|
  json.extract! monthly_cashflow, :id, :month, :vote_number, :subdepartment_id, :department_id, :mscore_classification_id, :line_item, :operational_expenditure, :revenue, :capital_expenditure
  json.url monthly_cashflow_url(monthly_cashflow, format: :json)
end
