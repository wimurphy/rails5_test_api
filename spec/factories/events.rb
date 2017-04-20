FactoryGirl.define do
  factory :event do
    name { Faker::Name.name }
    created_by { Faker::Number.number(10) }
  end
end
