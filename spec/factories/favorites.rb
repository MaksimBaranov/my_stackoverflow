# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :favorite do
    user_id nil
    favoriteable_id nil
    favoriteable_type nil
  end
end
