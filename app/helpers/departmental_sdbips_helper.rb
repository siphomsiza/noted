module DepartmentalSdbipsHelper
	def options_for_group_selection
		options_for_select([["Department","0"],["Performance Standard","1"],["KPA","2"]])
	end
	def options_for_graph_selection
		options_for_select([["Bar Graph","0"],["Pie Chart","1"]])
	end
	def options_for_performance_standard
		options_for_select(["KPI Not Yet Measured","KPI Not Met", "KPI Almost Met", "KPI Met", "KPI Well Met", "KPI Extremely Well Met"])
	end
	
	def editors
		current_user && (current_user.admin? || current_user.super_admin?)
	end
end
