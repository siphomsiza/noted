
FactoryGirl.define do
  factory :strategic_objective do
  

    name {Faker::Internet.name }
    list_id { Faker::PhoneNumber.list_id }
  end

end    