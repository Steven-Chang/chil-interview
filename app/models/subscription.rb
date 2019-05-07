# frozen_string_literal: true

class Subscription < ApplicationRecord
	# === ASSOCIATIONS ===
	belongs_to :subscription_option
	has_one :purchase, as: :purchasable, dependent: :restrict_with_error

	# === VALIDATIONS ===
	validates :active, presence: true
end
