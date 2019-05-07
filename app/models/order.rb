# frozen_string_literal: true

class Order < ApplicationRecord
	# === ASSOCIATIONS ===
	belongs_to :post
	belongs_to :buyer, class_name: "User"
	belongs_to :seller, class_name: "User"

	# === VALIDATIONS ===
	validates :post_id, uniqueness: { scope: [:buyer_id, :seller_id] }
end
