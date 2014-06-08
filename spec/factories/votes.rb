# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    value  { [1, -1].sample }
    user_id nil
    voteable_id nil
    voteable_type nil
  end
end
