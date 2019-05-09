# frozen_string_literal: true

class StripeChargeService
  DEFAULT_CURRENCY = "aud"

  def initialize(params, user)
    @stripe_token = params[:stripeToken]
    @amount_in_cents = (params[:amount] * 100).to_i
    @user = user
  end

  def call
    create_charge
  end

  private

  attr_accessor :user, :stripe_token, :amount_in_cents

  def create_charge
    Stripe::Charge.create(
      amount: amount_in_cents,
      description: "#{user.email}",
      currency: DEFAULT_CURRENCY,
      source: stripe_token
    )
  end
end
