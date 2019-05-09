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
    Subscription.transaction do
      save!
      amount = subscription_option.price
      purchase = purchases.build(user: current_user, amount: amount)
      purchase.save!
      params[:purchase_id] = purchase.id
      stripe_response = StripeChargeService.new(params, current_user).call
      purchase.tranxactions.create!(amount: amount, stripe_charge_id: stripe_response["id"])
    end
	end
end
