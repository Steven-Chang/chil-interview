# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
	let(:subscription) { build(:subscription) }
	let(:user) { create(:user) }
	let(:post) { create(:post) }
	let(:purchase_for_subscription) { create(:purchase, purchasable: subscription) }
	describe "ASSOCIATIONS" do
		it { should have_many(:comments).dependent(:destroy) }
		it { should have_many(:purchases).dependent(:restrict_with_error) }
		it { should have_many(:posts).dependent(:destroy) }
		it { should have_many(:subscriptions).through(:purchases) }
	end

	describe "VALIDATIONS" do
		it { should validate_uniqueness_of(:username) }
		it { should validate_uniqueness_of(:email).case_insensitive }
	end

	describe "INSTANCE METHODS" do
		describe "#authored_post?" do
			it "returns true if user has authored post" do
				expect(post.author.authored_post?(post)).to be true
			end

			it "returns false if use is not the author" do
				expect(user.authored_post?(post)).to be false
			end
		end

		describe "#active_subscription_to_post?" do
			context "when user has a subscription to post" do
				before do
					subscription.subscribable = post
					subscription.save!
				end

				it "returns true if use has active subscription to post" do
					expect(purchase_for_subscription.user.active_subscription_to_post?(post)).to be true
				end

				it "returns false if user has an inactive subscription to post" do
					subscription.update!(active: false)
					expect(purchase_for_subscription.user.active_subscription_to_post?(post)).to be false
				end
			end

			it "returns false if user doesn't have a subscription to post" do
				expect(user.active_subscription_to_post?(post)).to be false
			end
		end

		describe "#active_subscription_to_site" do
			context "when user has a subscription to site" do
				before do
					subscription.update!(subscribable_type: "Site")
				end

				it "returns true if user has a active subscription to site" do
					subscription.update!(active: true)
					expect(purchase_for_subscription.user.active_subscription_to_site?).to be true
				end

				it "returns false unless user has a active subscription to site" do
					subscription.update!(active: false)
					expect(purchase_for_subscription.user.active_subscription_to_site?).to be false
				end
			end

			it "returns false if user doesn't have a subscription to post" do
				expect(user.active_subscription_to_site?).to be false
			end
		end

		describe "#can_view_full_post?" do
			after do
				user.can_view_full_post?(post)
			end

			it "calls #authored_post?(post)" do
				expect(user).to receive(:authored_post?).with(post)
			end

			it "calls #active_subscription_to_post?(post)" do
				expect(user).to receive(:active_subscription_to_post?).with(post)
			end

			it "calls #active_subscription_to_site?" do
				expect(user).to receive(:active_subscription_to_site?)
			end
		end

		describe "#name" do
			it "returns a users first name and last name combined" do
				expect(user.name).to eq("#{user.first_name} #{user.last_name}")
			end
		end
	end
end
