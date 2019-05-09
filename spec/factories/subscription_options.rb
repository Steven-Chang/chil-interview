# frozen_string_literal: true

FactoryBot.define do
  factory :subscription_option do
  	sequence(:subscribable_type) { |n| "Post#{n}" }
  	sequence(:description) { |n| "description-#{n}" }
    price { 123.11 }
  end
end
