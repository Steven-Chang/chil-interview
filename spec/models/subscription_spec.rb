# frozen_string_literal: true

require "rails_helper"

RSpec.describe Subscription, type: :model do
	let(:user) { create(:user) }
	let(:subscription) { build(:subscription) }
	let(:params) do
		{}
	end
	let(:stripe_response) { { id: "1231dsf" } }

	describe "ASSOCIATIONS" do
		it { should belong_to(:subscribable).optional }
		it { should belong_to(:subscription_option) }
		it { should have_many(:purchases).dependent(:restrict_with_error) }
	end

	describe "CALLBACKS" do
		describe "before_save" do
			it "sets active to true if nil" do
				subscription.update!(active: nil)
				expect(subscription.active).to be true
			end

			it "doesn't change active to true if false" do
				subscription.update!(active: false)
				expect(subscription.active).to be false
			end
		end
	end

	describe "INSTANCE METHODS" do
		describe "#process_new_requests" do
			context "when stripe charge is successful" do
				before do
					allow_any_instance_of(StripeChargeService).to receive(:call).and_return(stripe_response)
				end

				it "saves the subscription" do
					expect(subscription).to receive(:save!)
					subscription.process_new_request(params, user)
				end

				it "creates a related purchase object" do
					subscription.process_new_request(params, user)
					purchase = subscription.purchases.first
					expect(purchase.purchasable).to eq(subscription)
					expect(purchase.amount).to eq(subscription.subscription_option.price)
					expect(purchase.user).to eq(user)
				end

				it "creates a related tranxaction" do
					subscription.process_new_request(params, user)
					purchase = subscription.purchases.first
					expect(purchase.tranxactions.first.amount).to eq(subscription.subscription_option.price)
					expect(purchase.tranxactions.first.stripe_charge_id).to eq(stripe_response["id"])
				end
			end

			context "when stripe charge is unsuccessful" do
				before do
					allow_any_instance_of(StripeChargeService).to receive(:call).and_raise(StandardError.new("error"))
				end

				it "rolls back everything" do
					expect { subscription.process_new_request(params, user) }.to raise_error
					expect(subscription.persisted?).to be false
					expect(subscription.purchases.count).to be 0
					expect(Tranxaction.count).to be 0
				end
			end
		end
	end
end
