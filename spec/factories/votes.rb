# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    value  { [1, -1].sample }
    user_id nil
    voteable_id nil
    voteable_type nil
  end

  factory :vote_with_value, class: 'Vote' do
    value 1
    user_id nil
    voteable_id nil
    voteable_type nil
  end
end
