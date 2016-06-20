json.array!(@capital_projects) do |capital_project|
  json.extract! capital_project, :id, :Department, :Subdepartment, :MscoreClassification, :MunCPRef, :IDPNumber, :VoteNumber, :ProjectName, :ProjectDescription, :FundingSource, :PlannedStartDate, :PlannedCompletionDate, :ActualStartDate, :ActualCompletionDate, :Ward, :Area, :July, :August, :September, :October, :November, :December, :January, :February, :March, :April, :May, :June
  json.url capital_project_url(capital_project, format: :json)
end
