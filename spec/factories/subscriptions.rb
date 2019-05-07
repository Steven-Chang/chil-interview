# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
  	active { true }

  	purchase
  	subscription_option
  end
end
