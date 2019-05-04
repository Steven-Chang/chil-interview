# frozen_string_literal: true

class Post < ApplicationRecord
	acts_as_taggable

	# === ASSOCIATIONS ===
	belongs_to :author, class_name: "User"
	has_many :comments, as: :commentable, dependent: :destroy

	# === VALIDATIONS ===
	validates :title, :body, presence: true

	# === SCOPES ===
	scope :ordered, -> { order(updated_at: :desc) }
end
