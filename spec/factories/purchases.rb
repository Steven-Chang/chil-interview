# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
  	user
  	association :purchasable, factory: :post
  end
end
