# frozen_string_literal: true

class Comment < ApplicationRecord
  # === ASSOCIATIONS ===
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User"
  has_many :comments, as: :commentable, dependent: :destroy

  # === VALIDATIONS ===
  validates :body, presence: true
end
