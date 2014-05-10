# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
  user
  question
    text "MyText"*20
  end

  factory :invalid_answer, class: "Answer" do
    text   nil
  end
end
