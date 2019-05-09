# frozen_string_literal: true

class StripeChargeService
  DEFAULT_CURRENCY = "aud"

  def initialize(params, user)
    @stripe_token = params[:stripeToken]
    @purchase = Purchase.find(params[:purchase_id])
    @user = user
  end

  def call
    create_charge
  end

  private

  attr_accessor :user, :stripe_token, :purchase

  def create_charge
    Stripe::Charge.create(
      amount: purchase.amount_in_cents,
      description: "#{user.email} purchase_id: #{purchase.id}",
      currency: DEFAULT_CURRENCY,
      source: stripe_token
    )
  end
end
