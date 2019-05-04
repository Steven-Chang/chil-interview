# frozen_string_literal: true

class Comment < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :post
  belongs_to :author, class_name: "User"

  # === VALIDATIONS ===
  validates :body, :post_id, :author_id, presence: true
end
