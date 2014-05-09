# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
  user
    title "MyString"*5
    body "MyText"*20
  end

  factory :invalid_question, class: "Question" do
    title   nil
    body  nil
  end
end
