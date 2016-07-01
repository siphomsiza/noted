class List < ActiveRecord::Base
	include PublicActivity::Common
	has_many :areas, :dependent => :destroy
	has_many :funding_sources, :dependent => :destroy
	has_many :kpi_calculation_types, :dependent => :destroy
	has_many :kpi_concepts, :dependent => :destroy
	has_many :kpi_owners, :dependent => :destroy
	has_many :kpi_target_types, :dependent => :destroy
	has_many :kpi_types, :dependent => :destroy
	has_many :mscore_classifications, :dependent => :destroy
	has_many :kpas, :dependent => :destroy
	has_many :national_outcomes, :dependent => :destroy
	has_many :ndp_objectives, :dependent => :destroy
	has_many :predetermined_objectives, :dependent => :destroy
	has_many :provincial_strategic_outcomes, :dependent => :destroy
	has_many :reporting_categories, :dependent => :destroy
	has_many :risk_ratings, :dependent => :destroy
	has_many :strategic_objectives, :dependent => :destroy
	has_many :wards, :dependent => :destroy

	accepts_nested_attributes_for :areas, allow_destroy: true
	accepts_nested_attributes_for :funding_sources, allow_destroy: true
	accepts_nested_attributes_for :kpi_calculation_types, allow_destroy: true
	accepts_nested_attributes_for :kpi_concepts, allow_destroy: true
	accepts_nested_attributes_for :kpi_owners, allow_destroy: true
	accepts_nested_attributes_for :kpi_target_types, allow_destroy: true
	accepts_nested_attributes_for :kpi_types, allow_destroy: true
	accepts_nested_attributes_for :mscore_classifications, allow_destroy: true
	accepts_nested_attributes_for :kpas, allow_destroy: true
	accepts_nested_attributes_for :national_outcomes, allow_destroy: true
	accepts_nested_attributes_for :ndp_objectives, allow_destroy: true
	accepts_nested_attributes_for :predetermined_objectives, allow_destroy: true
	accepts_nested_attributes_for :provincial_strategic_outcomes, allow_destroy: true
	accepts_nested_attributes_for :reporting_categories, allow_destroy: true
	accepts_nested_attributes_for :risk_ratings, allow_destroy: true
	accepts_nested_attributes_for :strategic_objectives, allow_destroy: true
	accepts_nested_attributes_for :wards, allow_destroy: true

	def area_for_form
    	collection = areas.where(list_id: id)
    	collection.any? ? collection : areas.build
  	end

	def funding_source_for_form
    	collection = funding_sourcess.where(list_id: id)
    	collection.any? ? collection : funding_sources.build
  	end

	def kpi_calculation_type_for_form
    	collection = kpi_calculation_types.where(list_id: id)
    	collection.any? ? collection : kpi_calculation_types.build
  	end

	def kpi_concept_for_form
    	collection = kpi_concepts.where(list_id: id)
    	collection.any? ? collection : kpi_concepts.build
  	end

	def kpi_owner_for_form
    	collection = kpi_owners.where(list_id: id)
    	collection.any? ? collection : kpi_owners.build
  	end

	def kpi_target_type_for_form
    	collection = kpi_target_types.where(list_id: id)
    	collection.any? ? collection : kpi_target_types.build
  	end

	def kpi_type_for_form
    	collection = kpi_types.where(list_id: id)
    	collection.any? ? collection : kpi_types.build
  	end

	def mscore_classification_for_form
    	collection = mscore_classifications.where(list_id: id)
    	collection.any? ? collection : mscore_classifications.build
  	end

	def kpa_for_form
    	collection = kpas.where(list_id: id)
    	collection.any? ? collection : kpas.build
  	end

	def national_outcome_for_form
    	collection = national_outcomes.where(list_id: id)
    	collection.any? ? collection : national_outcomes.build
  	end

  	def ndp_objective_for_form
    	collection = ndp_objectives.where(list_id: id)
    	collection.any? ? collection : ndp_objectives.build
  	end

  	def predetermined_objective_for_form
    	collection = predetermined_objectives.where(list_id: id)
    	collection.any? ? collection : predetermined_objectives.build
  	end

  	def provincial_strategic_outcome_for_form
    	collection = provincial_strategic_outcomes.where(list_id: id)
    	collection.any? ? collection : provincial_strategic_outcomes.build
  	end

  	def reporting_category_for_form
    	collection = reporting_categories.where(list_id: id)
    	collection.any? ? collection : reporting_categories.build
  	end

  	def risk_rating_for_form
    	collection = risk_ratings.where(list_id: id)
    	collection.any? ? collection : risk_ratings.build
  	end

  	def strategic_objective_for_form
    	collection = strategic_objectives.where(list_id: id)
    	collection.any? ? collection : strategic_objectives.build
  	end

end
