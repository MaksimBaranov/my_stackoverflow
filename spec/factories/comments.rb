# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user
    text Faker::Lorem.paragraph(4)
  end

  factory :invalid_comment, class: 'Comment' do
    user
    text nil
  end
end
