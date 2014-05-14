# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    text Faker::Lorem.paragraph(4)
  end

  factory :invalid_comment, class: 'Comment' do
    text nil
  end
end
