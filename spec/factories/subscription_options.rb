FactoryBot.define do
  factory :subscription_option do
  	sequence(:description) { |n| "description-#{n}" }
    price { 123.11 }
  end
end
