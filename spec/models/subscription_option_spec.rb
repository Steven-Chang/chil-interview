# frozen_string_literal: true

require "rails_helper"

RSpec.describe SubscriptionOption, type: :model do
	let(:subscription_option) { create(:subscription_option) }
	let(:subscribable_type) { "Post" }

	describe "ASSOCIATIONS" do
		it { should have_many(:subscriptions).dependent(:restrict_with_error) }
	end

	describe "CALLBACKS" do
		describe "before_validation" do
			it "downcases the description" do
				new_description = "BUCKS IN 5"
				subscription_option.update!(description: new_description)
				expect(subscription_option.description).to eq(new_description.downcase)
			end
		end
	end

	describe "VALIDATIONS" do
		it { should validate_numericality_of(:price) }
		it { should validate_presence_of(:subscribable_type) }
		it { should validate_presence_of(:description) }
		it do
			subscription_option
			should validate_uniqueness_of(:subscribable_type).scoped_to(:description)
		end
	end

	describe "CLASS METHODS" do
		describe ".subscription_options_for_class" do
			before do
				create(:subscription_option, subscribable_type: subscribable_type)
				create(:subscription_option, subscribable_type: "Site")
			end

			it "returns subscription options for the class name provided and for the site" do
				expect(SubscriptionOption.subscription_options_for_class("Post").ids.sort).to eq(SubscriptionOption.all.ids.sort)
			end

			it "doesn't returns subscription options class names not provided (apart from Site)" do
				site_subscription_option_id = SubscriptionOption.find_by(subscribable_type: "Site").id
				expect(SubscriptionOption.subscription_options_for_class(subscribable_type + "x").ids.first)
				  .to eq(site_subscription_option_id)
			end
		end
	end
end
