require 'active_record/fixtures'
if !Rails.env.production?
20.times do |n|
name  = Faker::Name.first_name
lastname = Faker::Name.last_name
title =Faker::Name.title
location = Faker::Address.city
landline=Faker::PhoneNumber.phone_number
mobile=Faker::PhoneNumber.cell_phone
  email = "example-#{n+21}@railstutorial.org"
  password = "password"
  User.create!(firstname:  name,
              surname: lastname,
              email: email,
              location: location,
              mobile: mobile,
              landline: landline,
              password:              password,
              password_confirmation: password,
              title: title,
              id_number: Faker::Number.number(13),
              birth_date: Time.now.strftime("/%dd%mm/%YYYY"),
              status: "Active",
              activated: true,
              admin: false,
              activated_at: Time.zone.now)
end

MasterSetup.create!(
  municipality: "Sakhisizwe Local Municipality",
  logo: File.open(File.join(Rails.root,'/app/assets/images','mkhondo-logo.png')),# File.open("../app/assets/images/mkhondo-logo.png"),
  province: "Eastern Cape",
  #latitude: ,
  #longitude: ,
)
end
