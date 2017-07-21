FactoryGirl.define do
  factory :beer do
    name "The perfect beer"
    country "USA"
    manufacturer "USA beer co."
    price 100000.00
    description "perfect"
    association :category
  end
end
