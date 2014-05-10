# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
  user
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraph(4)
  end

  factory :invalid_question, class: "Question" do
    title   nil
    body  nil
  end
end
