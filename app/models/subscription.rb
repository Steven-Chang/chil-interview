# frozen_string_literal: true

class Subscription < ApplicationRecord
	# === ASSOCIATIONS ===
	belongs_to :subscribable, polymorphic: true, optional: true
	belongs_to :subscription_option
	has_many :purchases, as: :purchasable, dependent: :restrict_with_error

	# === CALLBACKS ===
	before_save do
		self.active = true if active.nil?
	end

	# === INSTANCE METHODS ===
	def process_new_request(params, current_user)
		amount = subscription_option.price
		params[:amount] = amount
		stripe_response = StripeChargeService.new(params, current_user).call
    save!
    purchase = purchases.build(user: current_user, amount: amount)
    purchase.save!
    purchase.tranxactions.create!(amount: amount, stripe_charge_id: stripe_response["id"])
	end
end
