# frozen_string_literal: true

require "rails_helper"

RSpec.describe SubscriptionOption, type: :model do
	let!(:subscription_option) { create(:subscription_option) }

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
		it { should validate_uniqueness_of(:description).case_insensitive }
		it { should validate_numericality_of(:price) }
	end
end
