FactoryGirl.define do
  factory :people do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    company { Faker::Company.name }
  end
end
