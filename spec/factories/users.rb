FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Network.email }
    password "WellIDontKnowWhatToDoWithMyself"
  end
end
