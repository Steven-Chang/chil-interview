# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:author] do
    first_name { "John" }
    last_name { "Smith" }
    sequence(:username) { |n| "john.smith#{n}" }
    password { "Password123" }
  end
end
