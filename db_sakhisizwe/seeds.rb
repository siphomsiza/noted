require 'active_record/fixtures'
User.create!( firstname: "Casey Abram",
              surname: "Seabela",
              username: "caseabela",
              email: "casey@sableassets.com",
              password: "sableassets",
              title: "Mr",
              mobile: "0764338939",
              landline: "0112563984",
              id_number: Faker::Number.number(13),
              birth_date: Time.now.strftime("/%dd%mm/%YYYY"),
              location: "Riversands Incubation Hub",
              password_confirmation: "sableassets",
              super_admin: true,
              activated: true,status: "Active",
              activated_at: Time.zone.now)
              User.create!(firstname: 'Sandile',
                           surname: 'Swana',
                           username: 'sswana',
                           email: 'sandile@sableassets.co.za',
                           password: 'sableassets',
                           title: 'Mr',
                           mobile: '0832687954',
                           landline: '0112563984',
                           id_number: Faker::Number.number(13),
                           birth_date: Time.now.strftime('/%dd%mm/%YYYY'),
                           location: 'Riversands Incubation Hub',
                           password_confirmation: 'sableassets',
                           super_admin: true,
                           activated: true, status: 'Active',
                           activated_at: Time.zone.now)
              User.create!(firstname: 'Bushidi',
                           surname: 'Rachidi',
                           username: 'brachidi',
                           email: 'rachidi@sableassets.co.za',
                           password: 'sableassets',
                           title: 'Mr',
                           mobile: '0764338939',
                           landline: '0112563984',
                           id_number: Faker::Number.number(13),
                           birth_date: Time.now.strftime('/%dd%mm/%YYYY'),
                           location: 'Riversands Incubation Hub',
                           password_confirmation: 'sableassets',
                           super_admin: true,
                           activated: true, status: 'Active',
                           activated_at: Time.zone.now)
20.times do |n|
name  = Faker::Name.first_name
lastname = Faker::Name.last_name
title =Faker::Name.prefix
location = Faker::Address.city
landline=Faker::PhoneNumber.phone_number
mobile=Faker::PhoneNumber.cell_phone
  email = "example-#{n+41}@railstutorial.org"
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
  logo: File.open(File.join(Rails.root,'/app/assets/images','sakhisizwe-logo.jpeg')),# File.open("../app/assets/images/mkhondo-logo.png"),
  province: "Eastern Cape",
  address: 'Sakhisizwe Municipality<br/>15 Maclear Rd,<br/>Elliot,<br/> 5460<br/>Eastern Cape, South Africa',
  latitude: -31.333819,
  longitude: 27.849731,
)

$i=0
$num = 12
while $i < $num  do
  month_number = 7 + $i
  if month_number <= 12
  month_beginning = Date.new(Date.today.year, month_number)
  month_ending = month_beginning.end_of_month
  period = month_ending.strftime("%d-%b-%Y")
  primary_reminder = period.to_date + 7.days
  primary_closure = period.to_date + 14.days
  secondary_reminder = period.to_date + 7.days
  secondary_closure = period.to_date + 16.days
  else
    month_number -= 12
    month_beginning = Date.new(Date.today.year, month_number)
    month_beginning += 1.year
    month_ending = month_beginning.end_of_month
    period = month_ending.strftime("%d-%b-%Y")
    primary_reminder = period.to_date + 7.days
    primary_closure = period.to_date + 14.days
    secondary_reminder = period.to_date + 7.days
    secondary_closure = period.to_date + 16.days
  end
  SdbipTimePeriod.create!(period: period,primary_reminder: primary_reminder,primary_closure: primary_closure, secondary_reminder: secondary_reminder,secondary_closure: secondary_closure)
   $i +=1
end
