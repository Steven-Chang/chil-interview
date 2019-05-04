# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "RSpec Post Title #{n}" }
    body { "This is an example post" }
    author

    factory :post_with_comments do
      transient do
        comments_count { 5 }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, commentable: post)
      end
    end
  end
end
