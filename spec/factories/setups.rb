
FactoryGirl.define do
  factory :setup do
  

    performance_comments {Faker::Internet.performance_comments }
    performance_length {Faker::Internet.performance_length }
    project_life_cycle {Faker::Internet.project_life_cycle }
    include_previous_departmental_actual {Faker::Internet.include_previous_departmental_actual }
    include_departmental_previous_comments {Faker::Internet.include_departmental_previous_comments }
    include_departmental_next_target {Faker::Internet.include_departmental_next_target }
    include_toplayer_previous_target {Faker::Internet.include_toplayer_previous_target }
    include_toplayer_next_target {Faker::Internet.include_toplayer_next_target }
    include_toplayer_previous_comments {Faker::Internet.include_toplayer_previous_comments }
    attach_poe {Faker::Internet.attach_poe }
   
  end

end

