# frozen_string_literal: true

class Purchase < ApplicationRecord
	# === ASSOCIATIONS ===
	belongs_to :user
	belongs_to :purchasable, polymorphic: true
	has_many :tranxactions, dependent: :restrict_with_error

	# === VALIDATIONS ===
	validates :user_id, uniqueness: { scope: [:purchasable_type, :purchasable_id] }

	# === INSTANCE METHODS ===
	def amount_in_cents
		(amount * 100).to_i
	end
end
