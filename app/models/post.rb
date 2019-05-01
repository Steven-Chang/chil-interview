# frozen_string_literal: true

class Post < ApplicationRecord
	acts_as_taggable

	# === ASSOCIATIONS ===
	belongs_to :author, class_name: "User"
	has_many :comments, dependent: :destroy

	# === VALIDATIONS ===
	validates :title, :body, :author_id, presence: true

	# === SCOPES ===
	scope :ordered, -> { order(updated_at: :desc) }
end
