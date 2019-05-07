# frozen_string_literal: true

class Tranxaction < ApplicationRecord
	# === ASSOCIATIONS ===
	belongs_to :purchase

	# === VALIDATIONS ===
	validates :amount, numericality: true
end
