
FactoryGirl.define do
  factory :subdepartment do
  

    subdepartment_name {Faker::Internet.subdepartment_name }
    department_id { Faker::PhoneNumber.department_id }
  end

end