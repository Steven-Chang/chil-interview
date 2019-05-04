# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { "This is an example comment" }
    author

    trait :for_post do
      association :commentable, factory: :post
    end

    trait :for_comment do
      association :commentable, factory: :comment
    end
  end
end
