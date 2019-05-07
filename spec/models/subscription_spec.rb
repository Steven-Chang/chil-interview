# frozen_string_literal: true

require "rails_helper"

RSpec.describe Subscription, type: :model do
	describe "ASSOCIATIONS" do
		it { should belong_to(:subscription_option) }
		it { should have_one(:purchase).dependent(:restrict_with_error) }
	end

	describe "VALIDATIONS" do
		it { should validate_presence_of(:active) }
	end
end
