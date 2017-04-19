FactoryGirl.define do
  factory :event do
    name { Faker::Name.name }
  end
end
