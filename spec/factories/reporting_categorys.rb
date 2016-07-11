
FactoryGirl.define do
  factory :reporting_category do
  

    name {Faker::Internet.name }
    list_id { Faker::PhoneNumber.list_id }
  end

end

