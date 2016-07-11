
FactoryGirl.define do
  factory :ward do
  

    name {Faker::Internet.name }
    ward_no { Faker::PhoneNumber.ward_number }
    mun_ref { Faker::PhoneNumber.mun_reference }
    area_id { Faker::PhoneNumber.area_id }
  end

end