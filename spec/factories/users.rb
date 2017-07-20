FactoryGirl.define do
  factory :user, aliases: [:admin] do
    name "Aaron"
    sequence(:email) { |n| "test#{n}@gmail.com"}
    password "123456"

    trait :admin do
      role 1
    end
  end
end
