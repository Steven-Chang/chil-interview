# frozen_string_literal: true

class SubscriptionOption < ApplicationRecord
	# === ASSOCIATIONS ===
	has_many :subscriptions, dependent: :restrict_with_error

	# === CALLBACKS ===
	before_validation do
		self.description = description.downcase if description
	end

	# === VALIDATIONS ===
	validates :description, uniqueness: { case_sensitive: false }
	validates :price, numericality: true
end
