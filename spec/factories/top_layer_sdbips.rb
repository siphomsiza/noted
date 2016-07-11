
FactoryGirl.define do
  factory :top_layer_sdbip do
  

    name {Faker::Internet.name }
    ward_no { Faker::PhoneNumber.ward_number }
    mun_ref { Faker::PhoneNumber.mun_reference }
    area_id { Faker::PhoneNumber.area_id }
  end

end