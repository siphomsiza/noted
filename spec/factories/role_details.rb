FactoryGirl.define do
  factory :role_detail do
  

    role_id {Faker::Internet.role_id }
    subdepartment_id { Faker::PhoneNumber.subdepartment_id }
    department_id { Faker::PhoneNumber.department_id }
  end

end

