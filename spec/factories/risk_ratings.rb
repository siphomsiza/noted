FactoryGirl.define do
  factory :risk_rating do
  

    name {Faker::Internet.name }
    code { Faker::PhoneNumber.code }
    list_id { Faker::PhoneNumber.list_id }
  end

end