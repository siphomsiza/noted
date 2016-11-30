
FactoryGirl.define do
  factory :setup do
    performance_comments false
    performance_length false
    project_life_cycle false
    include_previous_departmental_actual false
    include_departmental_previous_comments false
    include_departmental_next_target false
    include_toplayer_previous_target false
    include_toplayer_next_target false
    include_toplayer_previous_comments false
    attach_poe false
  end
end
