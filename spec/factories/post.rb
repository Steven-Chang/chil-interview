# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "RSpec Post Title #{n}" }
    body { "This is an example post" }
    author
  end
end
