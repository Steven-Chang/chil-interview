# frozen_string_literal: true

class SubscriptionOption < ApplicationRecord
	# === ASSOCIATIONS ===
	has_many :subscriptions, dependent: :restrict_with_error

	# === CALLBACKS ===
	before_validation do
		self.description = description.downcase if description
	end

	# === VALIDATIONS ===
	validates :description, presence: true
	validates :subscribable_type, presence: true
	validates :price, numericality: true
	validates :subscribable_type, uniqueness: { scope: [:description] }

	# === CLASS METHODS ===
	def self.subscription_options_for_class(class_name)
		where("subscribable_type = 'Site'").or(where("subscribable_type = ?", class_name))
	end
end
