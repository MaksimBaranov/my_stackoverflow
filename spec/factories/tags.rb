# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
     user
     name Faker::Lorem.word
  end
end
